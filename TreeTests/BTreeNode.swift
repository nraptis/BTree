//
//  BTreeNode.swift
//  TreeTests
//
//  Created by Nicky Taylor on 11/26/22.
//

import Foundation

class BTreeNode<Element: Comparable>: Hashable {
    
    var name = "unknown"
    
    static func == (lhs: BTreeNode<Element>, rhs: BTreeNode<Element>) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
    required init(data: BTreeNodeData<Element>) {
        self.data = data
    }
    
    static func createLeaf(order: Int, parent: BTreeNode<Element>?) -> BTreeNode<Element> {
        BTreeNode(data: BTreeNodeData.createLeaf(order: order, parent: parent))
    }
    
    static func createInternal(order: Int, parent: BTreeNode<Element>?) -> BTreeNode<Element> {
        BTreeNode(data: BTreeNodeData.createInternal(order: order, parent: parent))
    }
    
    static func createRootLeaf(order: Int) -> BTreeNode<Element> {
        let result = BTreeNode(data: BTreeNodeData.createRootLeaf(order: order))
        result.rightmost = result
        result.parent = result
        return result
    }
    
    static func createRootInternal(order: Int, parent: BTreeNode<Element>?) -> BTreeNode<Element> {
        let result = BTreeNode(data: BTreeNodeData.createRootInternal(order: order, parent: parent))
        return result
    }
    
    var data: BTreeNodeData<Element>
    var count: Int {
        get { data.count }
        set { data.count = newValue }
    }
    
    var index: Int {
        get { data.index }
        set { data.index = newValue }
    }
    
    var order: Int {
        get { data.order }
    }
    
    var isLeaf: Bool {
        get { data.isLeaf }
        set { data.isLeaf = newValue }
    }
    
    var isRoot: Bool {
        get { data.isRoot }
        set { data.isRoot = newValue }
    }
    
    
    var rightmost: BTreeNode<Element>? {
        get { data.rightmost }
        set { data.rightmost = newValue }
    }
    
    /*
    var leftmost: BTreeNode<Element>? {
        get { data.leftmost }
        set { data.leftmost = newValue }
    }
    */
    
    var parent: BTreeNode<Element>? {
        get {
            //guard let result = data.parent else {
            //    fatalError("BTreeNode.parent parent is null")
            //}
            
            return data.parent
        }
        set {
            data.parent = newValue
        }
    }
    
    func value(index: Int) -> Element? {
        //guard index >= 0 && index < data.count else {
        //    fatalError("BTreeNode.value(index: Int) 1 index (\(index)) out of range [0..<\(data.count)]")
        //}
        guard index >= 0 && index < data.values.count else {
            fatalError("BTreeNode.value(index: Int) 2 index (\(index)) out of range [0..<\(data.values.count)]")
        }
        
        return data.values[index]
    }
    
    func child(index: Int) -> BTreeNode<Element>? {
        /*
        guard data.count > 0 else {
            fatalError("BTreeNode.child(index: Int) 1 data.count (\(data.count)) is 0")
        }
        guard index >= 0 && index <= (data.count + 1) else {
            fatalError("BTreeNode.child(index: Int) 1 index (\(index)) out of range [0...\(data.count)]")
        }
        */
        guard index >= 0 && index < data.children.count else {
            fatalError("BTreeNode.child(index: Int) 2 index (\(index)) out of range [0..<\(data.children.count)]")
        }
        return data.children[index]
    }
    
    func setChildren(array: [BTreeNode]) {
        if order > 0 {
            let ceiling = min(order + 1, array.count)
            for index in 0..<ceiling {
                set_child(i: index, node: array[index])
            }
        }
    }
    
    func swap(node: BTreeNode<Element>) {
        
        //assert(leaf() == x->leaf());
        guard isLeaf == node.isLeaf else {
            fatalError("BTreeNode.swap() isLeaf (\(isLeaf)) != node.isLeaf (\(node.isLeaf))")
        }

        // Swap the values.
        /*
        for (int i = count(); i < x->count(); ++i) {
          value_init(i);
        }
        for (int i = x->count(); i < count(); ++i) {
          x->value_init(i);
        }
         */
         
        //int n = std::max(count(), x->count());
        let n = max(count, node.count)
        
        //for (int i = 0; i < n; ++i) {
        //  value_swap(i, x, i);
        //}
        var i = 0
        while i < n {
            value_swap(i: i, x: node, j: i)
            i += 1
        }
        
        //for (int i = count(); i < x->count(); ++i) {
        //  x->value_destroy(i);
        //}
        i = count
        while i < node.count {
            node.value_destroy(i: i)
            i += 1
        }
        
        //for (int i = x->count(); i < count(); ++i) {
        //  value_destroy(i);
        //}
        i = node.count
        while i < count {
            value_destroy(i: i)
            i += 1
        }
        

        //if (!leaf()) {
        if !isLeaf {
        
          // Swap the child pointers.
          //for (int i = 0; i <= n; ++i) {
          //  btree_swap_helper(*mutable_child(i), *x->mutable_child(i));
          //}
            i = 0
            while i <= n {
                let hold = data.children[i]
                data.children[i] = node.data.children[i]
                node.data.children[i] = hold
                i += 1
            }
            
            //for (int i = 0; i <= count(); ++i) {
            //    x->child(i)->fields_.parent = x;
            //}
            
            i = 0
            while i <= count {
                node.data.children[i]?.parent = node
                i += 1
            }
          
            
            //for (int i = 0; i <= x->count(); ++i) {
            //    child(i)->fields_.parent = this;
            //}
            i = 0
            while i <= node.count {
                data.children[i]?.parent = self
                i += 1
            }
        }

        // Swap the counts.
        //btree_swap_helper(fields_.count, x->fields_.count);
        let hold = count
        count = node.count
        node.count = hold
    }
    
    func lowerBound(element: Element) -> Int {
        var start = 0
        var end = data.count
        while start != end {
            let mid = (start + end) >> 1
            
            guard let value = value(index: mid) else {
                fatalError("BTreeNode.lowerBound() value missing index: \(mid) count: \(data.count)")
            }
            
            if element > value {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
    
    func upperBound(element: Element) -> Int {
        var start = 0
        var end = data.count
        while start != end {
            let mid = (start + end) >> 1
            
            guard let value = value(index: mid) else {
                fatalError("BTreeNode.upperBound() value missing index: \(mid) count: \(data.count)")
            }
            
            if element >= value {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
    
    //void btree_node<P>::split(btree_node *dest, int insert_position) {
    func split(dest: BTreeNode<Element>, insert_position: Int) {

        //assert(dest->count() == 0);
        guard dest.count == 0 else {
            fatalError("BTreeNode.split() dest.count (\(dest.count)) not 0")
        }

        // We bias the split based on the position being inserted. If we're
        // inserting at the beginning of the left node then bias the split to put
        // more values on the right node. If we're inserting at the end of the
        // right node then bias the split to put more values on the left node.
        //if (insert_position == 0) {
        if insert_position == 0 {
            //dest->set_count(count() - 1);
            //dest.count -= 1
            //if dest.count > 0 {
            //dest.count -= 1
            dest.count = count - 1
            //}
            
        //} else if (insert_position == max_count()) {
        } else if insert_position == order {
            
            //dest->set_count(0);
            
        } else {
            //dest->set_count(count() / 2);
            dest.count = count >> 1
        }
        
        //set_count(count() - dest->count());
        count = count - dest.count
        
        //assert(count() >= 1);
        guard count >= 1 else {
            fatalError("BTreeNode.split() count (\(count)) < 1")
        }

            // Move values from the left sibling to the right sibling.
        //for (int i = 0; i < dest->count(); ++i) {
        var i = 0
        while i < dest.count {
        
            //dest->value_init(i);
            //value_swap(count() + i, dest, i);
            value_swap(i: count + i, x: dest, j: i)
            
            //value_destroy(count() + i);
            value_destroy(i: count + i)
            
            i += 1
        }

        // The split key is the largest value in the left sibling.
        //set_count(count() - 1);
        count = count - 1
        
        //parent()->insert_value(position(), value_type());
        guard let parent = parent else {
            fatalError("BTreeNode.split() parent is null")
        }
        parent.insert_value(index: index, element: nil)
        
        //value_swap(count(), parent(), position());
        value_swap(i: count, x: parent, j: index)
        
        //value_destroy(count());
        value_destroy(i: count)
        
        //parent()->set_child(position() + 1, dest);
        parent.set_child(i: index + 1, node: dest)
        
        //if (!leaf()) {
        if !isLeaf {
            
            //for (int i = 0; i <= dest->count(); ++i) {
            i = 0
            while i <= dest.count {
            
                //assert(child(count() + i + 1) != NULL);
                guard let child = child(index: count + i + 1) else {
                    fatalError("BTreeNode.split() child missing count (\(count)) + i (\(i)) + 1")
                }
                
                //dest->set_child(i, child(count() + i + 1));
                dest.set_child(i: i, node: child)
                
                //*mutable_child(count() + i + 1) = NULL;
                data.children[count + i + 1] = nil
                
                i += 1
            }
        }
    }
    
    //inline void btree_node<P>::insert_value(int i, const value_type &x) {
    func insert_value(index: Int, element: Element?) {
        
        //assert(i <= count());
        guard index <= count else {
            fatalError("BTreeNode.insert_value(index: Int, element: Element) index (\(index)) > count (\(count))")
        }
        
        guard index >= 0 else {
            fatalError("BTreeNode.insert_value(index: Int, element: Element) index (\(index)) < 0")
        }
        
        guard order >= 1 else {
            fatalError("BTreeNode.insert_value(index: Int, element: Element) order (\(order)) < 1")
        }
        
        guard count < order else {
            fatalError("BTreeNode.insert_value(index: Int, element: Element) count (\(count)) >= order (\(order))")
        }
        
        //value_init(count(), x);
        //for (int j = count(); j > i; --j) {
        var j = count
        while j > index {
            //value_swap(j, this, j - 1);
            
            data.values[j] = data.values[j - 1]
            j -= 1
        }
        
        data.values[index] = element
        
        //set_count(count() + 1);
        count += 1
        
        //if (!leaf()) {
        if !isLeaf {
        
            //guard data.children.count == (count + 1) else {
            //    fatalError("BTreeNode.insert_value(index: Int, element: Element) data.children.count (\(data.children.count)) != count (\(count))")
            //}
          
            //++i;
            let index = index + 1
          
            //for (int j = count(); j > i; --j) {
            j = count
            while j > index {
                
                
                //*mutable_child(j) = child(j - 1);
                data.children[j] = data.children[j - 1]
                
                //  child(j)->set_position(j);
                data.children[j]?.index = j
                
                j -= 1
            }
        }
    }
    
    //template <typename P>
    //inline void btree_node<P>::remove_value(int i) {
      
    func remove_value(index: Int) {
        //if (!leaf()) {
        if !isLeaf {
            //assert(child(i + 1)->count() == 0);
            guard var child = child(index: index + 1) else {
                fatalError("BTreeNode.remove_value(index: Int, element: Element) child index (\(index)) + 1 is null")
            }
            guard child.count == 0 else {
                fatalError("BTreeNode.remove_value(index: Int, element: Element) child index (\(index)) + 1, child.count (\(child.count)) expected 0")
            }
            
            //for (int j = i + 1; j < count(); ++j) {
            var j = index + 1
            while j < count {
                
                //*mutable_child(j) = child(j + 1);
                
                if let child = data.children[j + 1] {
                    data.children[j] = child
                    
                    //child(j)->set_position(j);
                    child.index = j
                } else {
                    fatalError("BTreeNode.remove_value(index: Int, element: Element) data.children[j (\(j))] is null")
                    data.children[j] = nil
                }
                
                j += 1
            }
            
            data.children[count] = nil
            //*mutable_child(count()) = NULL;
        }

        //set_count(count() - 1);
        count -= 1
        
        //for (; i < count(); ++i) {
        var index = index
        while index < count {
            //value_swap(i, this, i + 1);
            //value_swap(i: index, x: self, j: index + 1)
            data.values[index] = data.values[index + 1]
            index += 1
        }
        //value_destroy(i);
        //value_destroy(i: <#T##Int#>)
        data.values[index] = nil
    }
    
    
    //template <typename P>
    //void btree_node<P>::merge(btree_node *src) {
    func merge(source: BTreeNode<Element>) {
    
        //assert(parent() == src->parent());
        
        guard let parent = parent else {
            fatalError("BTreeNode.merge() parent is null")
        }
        guard parent === source.parent else {
            fatalError("BTreeNode.merge() parent != source.parent")
        }
        
        //assert(position() + 1 == src->position());
        guard (index + 1) == source.index else {
            fatalError("BTreeNode.merge() (index (\(index)) + 1) != source.index (\(source.index))")
        }
        
        // Move the delimiting value to the left node.
        //value_init(count());
        //value_swap(count(), parent(), position());
        value_swap(i: count, x: parent, j: index)
        

        // Move the values from the right to the left node.
        //for (int i = 0; i < src->count(); ++i) {
        var i = 0
        while i < source.count {
            //value_init(1 + count() + i);
            //value_swap(1 + count() + i, src, i);
            value_swap(i: 1 + count + i, x: source, j: i)
            
            //src->value_destroy(i);
            source.value_destroy(i: i)
            
            i += 1
        }

        //if (!leaf()) {
        if !isLeaf {
            
            // Move the child pointers from the right to the left node.
            //for (int i = 0; i <= src->count(); ++i) {
            i = 0
            while i <= source.count {
            
                //set_child(1 + count() + i, src->child(i));
                
                guard let sourceChild = source.child(index: i) else {
                    fatalError("BTreeNode.merge() source.child(index: i (\(i))) is null")
                }
                
                set_child(i: 1 + count + i, node: sourceChild)
                
                //*src->mutable_child(i) = NULL;
                source.data.children[i] = nil
                
                i += 1
            }
        }

        // Fixup the counts on the src and dest nodes.
        //set_count(1 + count() + src->count());
        count = ((1 + count) + source.count)
        
        //src->set_count(0);
        source.count = 0

        // Remove the value on the parent node.
        //parent()->remove_value(position());
        parent.remove_value(index: index)
    }
    
    
    //void value_swap(int i, btree_node *x, int j) {
        //params_type::swap(mutable_value(i), x->mutable_value(j));
    //}
    func value_swap(i: Int, x: BTreeNode<Element>, j: Int) {
        var hold = data.values[i]
        data.values[i] = x.data.values[j]
        x.data.values[j] = hold
    }
    
    func value_destroy(i: Int) {
        data.values[i] = nil
    }
    
    //void make_root() {
    func make_root() {
        //assert(parent()->is_root());
        guard let parent = parent else {
            fatalError("BTreeNode.make_root() parent is nul")
        }
        
        guard parent.isRoot else {
            fatalError("BTreeNode.make_root() parent.isRoot (\(parent.isRoot)) should be true")
        }
        
        //fields_.parent = fields_.parent->parent();
        self.parent = parent.parent
    }
    
    //void destroy() {
    func destroy() {
        //for (int i = 0; i < count(); ++i) {
        for index in 0..<count {
            //value_destroy(i);
            value_destroy(i: index)
        }
    }
    
    //void set_child(int i, btree_node *c) {
    func set_child(i: Int, node: BTreeNode<Element>) {
        //*mutable_child(i) = c;
        data.children[i] = node
        //c->fields_.parent = this;
        node.parent = self
        
        //c->fields_.position = i;
        node.index = i
    }
    
    //void btree_node<P>::rebalance_right_to_left(btree_node *src, int to_move) {
    func rebalance_right_to_left(src: BTreeNode<Element>, to_move: Int) {
        
        //assert(parent() == src->parent());
        guard parent === src.parent else {
            fatalError("BTreeNode.rebalance_right_to_left parent != src.parent")
        }
        
        //assert(position() + 1 == src->position());
        guard (index + 1) == src.index else {
            fatalError("BTreeNode.rebalance_right_to_left (index + 1) (\(index) + \(1)) != src.index (\(src.index))")
        }
        
        //assert(src->count() >= count());
        guard src.count >= count else {
            fatalError("BTreeNode.rebalance_right_to_left src.count (\(src.count)) < count (\(count))")
        }
        
        //assert(to_move >= 1);
        guard to_move >= 1 else {
            fatalError("BTreeNode.rebalance_right_to_left to_move (\(to_move)) < 1")
        }
        
        //assert(to_move <= src->count());
        guard to_move <= src.count else {
            fatalError("BTreeNode.rebalance_right_to_left to_move (\(to_move)) > src.count (\(src.count))")
        }

        // Make room in the left node for the new values.
        //for (int i = 0; i < to_move; ++i) {
        //    value_init(i + count());
        //}
        
        // Move the delimiting value to the left node and the new delimiting value
        // from the right node.
        
        //void value_swap(int i, btree_node *x, int j) {
            //params_type::swap(mutable_value(i), x->mutable_value(j));
        //}
        
        
        if let parent = parent {
            
            //value_swap(count(), parent(), position());
            //TODO: This will crash, undoubtedly...
            //value_swap(i: count, x: parent, j: index)
            
            value_swap(i: count, x: parent, j: index)
            
            //parent()->value_swap(position(), src, to_move - 1);
            parent.value_swap(i: index, x: src, j: to_move - 1)
            
        } else {
            fatalError("BTreeNode.rebalance_right_to_left to_move parent is nil")
        }
        
        // Move the values from the right to the left node.
        //for (int i = 1; i < to_move; ++i) {
        var i = 1
        while i < to_move {
            //value_swap(count() + i, src, i - 1);
            value_swap(i: count + i, x: src, j: i - 1)
            i += 1
        }
        // Shift the values in the right node to their correct position.
        //for (int i = to_move; i < src->count(); ++i) {
        i = to_move
        while i < src.count {
            //src->value_swap(i - to_move, src, i);
            src.value_swap(i: i - to_move, x: src, j: i)
            i += 1
        }
        
        //for (int i = 1; i <= to_move; ++i) {
        i = 1
        while i <= to_move {
            //src->value_destroy(src->count() - i);
            src.value_destroy(i: src.count - i)
            i += 1
        }

        //if (!leaf()) {
        if !isLeaf {
            
            /*
            for (int i = 0; i < to_move; ++i) {
                set_child(1 + count() + i, src->child(i));
            }
            */
            i = 0
            while i < to_move {
                if let srcChild = src.child(index: i) {
                    set_child(i: 1 + count + i, node: srcChild)
                }
                i += 1
            }
            
            /*
            for (int i = 0; i <= src->count() - to_move; ++i) {
                assert(i + to_move <= src->max_count());
                src->set_child(i, src->child(i + to_move));
                *src->mutable_child(i + to_move) = NULL;
            }
            */
            i = 0
            while i <= (src.count - to_move) {
                guard i + to_move <= src.order else {
                    fatalError("BTreeNode.rebalance_right_to_left i (\(i)) + to_move (\(to_move)) > src.order (\(src.order))")
                }
                guard let srcChild = src.child(index: i + to_move) else {
                    fatalError("BTreeNode.rebalance_right_to_left missing child i (\(i)) + to_move (\(to_move))")
                }
                src.set_child(i: i, node: srcChild)
                src.data.children[i + to_move] = nil
                i += 1
            }
        }

        // Fixup the counts on the src and dest nodes.
        //set_count(count() + to_move);
        count += to_move
        
        //src->set_count(src->count() - to_move);
        src.count -= to_move
    }
    
    //void btree_node<P>::rebalance_left_to_right(btree_node *dest, int to_move) {
    func rebalance_left_to_right(dest: BTreeNode<Element>, to_move: Int) {
     
        //assert(parent() == dest->parent());
        guard parent === dest.parent else {
            fatalError("BTreeNode.rebalance_left_to_right parent != dest.parent")
        }
        
        //assert(position() + 1 == dest->position());
        guard (index + 1) == dest.index else {
            fatalError("BTreeNode.rebalance_left_to_right (index + 1) (\(index) + \(1)) != dest.index (\(dest.index))")
        }
        
        //assert(count() >= dest->count());
        guard count >= dest.count else {
            fatalError("BTreeNode.rebalance_left_to_right count (\(count)) < dest.count (\(dest.count))")
        }
        
        
        //assert(to_move >= 1);
        guard to_move >= 1 else {
            fatalError("BTreeNode.rebalance_left_to_right to_move (\(to_move)) < 1")
        }
        
        //assert(to_move <= count());
        guard to_move <= count else {
            fatalError("BTreeNode.rebalance_left_to_right to_move (\(to_move)) > count (\(count))")
        }
        

        // Make room in the right node for the new values.
        //for (int i = 0; i < to_move; ++i) {
        //    dest->value_init(i + dest->count());
        //}
        
        //for (int i = dest->count() - 1; i >= 0; --i) {
        var i = dest.count - 1
        while i >= 0 {
        
            //dest->value_swap(i, dest, i + to_move);
            dest.value_swap(i: i, x: dest, j: i + to_move)
            
            i -= 1
        }

        // Move the delimiting value to the right node and the new delimiting value
        // from the left node.
        //dest->value_swap(to_move - 1, parent(), position());
        
        if let parent = parent {
            //TODO: Is this required?
            //dest.value_swap(i: to_move - 1, x: parent, j: index)
            dest.value_swap(i: to_move - 1, x: parent, j: index)
            
            //parent()->value_swap(position(), this, count() - to_move);
            parent.value_swap(i: index, x: self, j: count - to_move)
        } else {
            fatalError("BTreeNode.rebalance_left_to_right to_move parent is nil")
        }
        
        //value_destroy(count() - to_move);
        value_destroy(i: count - to_move)

        // Move the values from the left to the right node.
        //for (int i = 1; i < to_move; ++i) {
        i = 1
        while i < to_move {
            
            //value_swap(count() - to_move + i, dest, i - 1);
            value_swap(i: count - to_move + i, x: dest, j: i - 1)
            //value_destroy(count() - to_move + i);
            value_destroy(i: count - to_move + i)
            
            i += 1
        }

        //if (!leaf()) {
        if !isLeaf {
            
            /*
            for (int i = dest->count(); i >= 0; --i) {
              dest->set_child(i + to_move, dest->child(i));
              *dest->mutable_child(i) = NULL;
            }
            */
            
            i = dest.count
            while i >= 0 {
                guard let destChild = dest.child(index: i) else {
                    fatalError("BTreeNode.rebalance_left_to_right missing child index: \(i)")
                }
                dest.set_child(i: i + to_move, node: destChild)
                dest.data.children[i] = nil
                i -= 1
            }
            
            /*
            for (int i = 1; i <= to_move; ++i) {
              dest->set_child(i - 1, child(count() - to_move + i));
              *mutable_child(count() - to_move + i) = NULL;
            }
            */
            
            i = 1
            while i <= to_move {
                
                guard let selfChild = child(index: count - to_move + i) else {
                    fatalError("BTreeNode.rebalance_left_to_right missing child index: (count (\(i)) - to_move (\(to_move)) + i (\(i)))")
                }
                
                dest.set_child(i: i - 1, node: selfChild)
                
                //*mutable_child(count() - to_move + i) = NULL;
                data.children[count - to_move + i] = nil
                
                i += 1
            }
        }

        // Fixup the counts on the src and dest nodes.
        //set_count(count() - to_move);
        count -= to_move
        
        //dest->set_count(dest->count() + to_move);
        dest.count += to_move
    }
    
}

//class BTreeLeafNode<Element: Comparable>: BTreeNode<Element> {
    
//}


    
    //static func createLeaf(
    
    //var
    
    /*
    struct leaf_fields : public base_fields {
      // The array of values. Only the first count of these values have been
      // constructed and are valid.
      mutable_value_type values[kNodeValues];
    };

    struct internal_fields : public leaf_fields {
      // The array of child pointers. The keys in children_[i] are all less than
      // key(i). The keys in children_[i + 1] are all greater than key(i). There
      // are always count + 1 children.
      btree_node *children[kNodeValues + 1];
    };
    */
    


/*
template <typename Params>
class btree_node {
 public:
  
  enum {
    kValueSize = params_type::kValueSize,
    kTargetNodeSize = params_type::kTargetNodeSize,

    // Compute how many values we can fit onto a leaf node.
    kNodeTargetValues = (kTargetNodeSize - sizeof(base_fields)) / kValueSize,
    // We need a minimum of 3 values per internal node in order to perform
    // splitting (1 value for the two nodes involved in the split and 1 value
    // propagated to the parent as the delimiter for the split).
    kNodeValues = kNodeTargetValues >= 3 ? kNodeTargetValues : 3,

    kExactMatch = 1 << 30,
    kMatchMask = kExactMatch - 1,
  };

  struct leaf_fields : public base_fields {
    // The array of values. Only the first count of these values have been
    // constructed and are valid.
    mutable_value_type values[kNodeValues];
  };

  struct internal_fields : public leaf_fields {
    // The array of child pointers. The keys in children_[i] are all less than
    // key(i). The keys in children_[i + 1] are all greater than key(i). There
    // are always count + 1 children.
    btree_node *children[kNodeValues + 1];
  };

  struct root_fields : public internal_fields {
    btree_node *rightmost;
    size_type size;
  };

 public:
  // Getter/setter for whether this is a leaf node or not. This value doesn't
  // change after the node is created.
  bool leaf() const { return fields_.leaf; }

  // Getter for the position of this node in its parent.
  int position() const { return fields_.position; }
  void set_position(int v) { fields_.position = v; }

  // Getter/setter for the number of values stored in this node.
  int count() const { return fields_.count; }
  void set_count(int v) { fields_.count = v; }
  int max_count() const { return fields_.max_count; }

  // Getter for the parent of this node.
  btree_node* parent() const { return fields_.parent; }
  // Getter for whether the node is the root of the tree. The parent of the
  // root of the tree is the leftmost node in the tree which is guaranteed to
  // be a leaf.
  bool is_root() const { return parent()->leaf(); }
  void make_root() {
    assert(parent()->is_root());
    fields_.parent = fields_.parent->parent();
  }

  // Getter for the rightmost root node field. Only valid on the root node.
  btree_node* rightmost() const { return fields_.rightmost; }
  btree_node** mutable_rightmost() { return &fields_.rightmost; }

  // Getter for the size root node field. Only valid on the root node.
  size_type size() const { return fields_.size; }
  size_type* mutable_size() { return &fields_.size; }

  // Getters for the key/value at position i in the node.
  const key_type& key(int i) const {
    return params_type::key(fields_.values[i]);
  }
  reference value(int i) {
    return reinterpret_cast<reference>(fields_.values[i]);
  }
  const_reference value(int i) const {
    return reinterpret_cast<const_reference>(fields_.values[i]);
  }
  mutable_value_type* mutable_value(int i) {
    return &fields_.values[i];
  }

  // Swap value i in this node with value j in node x.
  void value_swap(int i, btree_node *x, int j) {
    params_type::swap(mutable_value(i), x->mutable_value(j));
  }

  // Getters/setter for the child at position i in the node.
  btree_node* child(int i) const { return fields_.children[i]; }
  btree_node** mutable_child(int i) { return &fields_.children[i]; }
  void set_child(int i, btree_node *c) {
    *mutable_child(i) = c;
    c->fields_.parent = this;
    c->fields_.position = i;
  }

  // Returns the position of the first value whose key is not less than k.
  template <typename Compare>
  int lower_bound(const key_type &k, const Compare &comp) const {
    return search_type::lower_bound(k, *this, comp);
  }
  // Returns the position of the first value whose key is greater than k.
  template <typename Compare>
  int upper_bound(const key_type &k, const Compare &comp) const {
    return search_type::upper_bound(k, *this, comp);
  }

  // Returns the position of the first value whose key is not less than k using
  // linear search performed using plain compare.
  template <typename Compare>
  int linear_search_plain_compare(
      const key_type &k, int s, int e, const Compare &comp) const {
    while (s < e) {
      if (!btree_compare_keys(comp, key(s), k)) {
        break;
      }
      ++s;
    }
    return s;
  }

  // Returns the position of the first value whose key is not less than k using
  // linear search performed using compare-to.
  template <typename Compare>
  int linear_search_compare_to(
      const key_type &k, int s, int e, const Compare &comp) const {
    while (s < e) {
      int c = comp(key(s), k);
      if (c == 0) {
        return s | kExactMatch;
      } else if (c > 0) {
        break;
      }
      ++s;
    }
    return s;
  }

  // Returns the position of the first value whose key is not less than k using
  // binary search performed using plain compare.
  template <typename Compare>
  int binary_search_plain_compare(
      const key_type &k, int s, int e, const Compare &comp) const {
    while (s != e) {
      int mid = (s + e) / 2;
      if (btree_compare_keys(comp, key(mid), k)) {
        s = mid + 1;
      } else {
        e = mid;
      }
    }
    return s;
  }

  // Returns the position of the first value whose key is not less than k using
  // binary search performed using compare-to.
  template <typename CompareTo>
  int binary_search_compare_to(
      const key_type &k, int s, int e, const CompareTo &comp) const {
    while (s != e) {
      int mid = (s + e) / 2;
      int c = comp(key(mid), k);
      if (c < 0) {
        s = mid + 1;
      } else if (c > 0) {
        e = mid;
      } else {
        // Need to return the first value whose key is not less than k, which
        // requires continuing the binary search. Note that we are guaranteed
        // that the result is an exact match because if "key(mid-1) < k" the
        // call to binary_search_compare_to() will return "mid".
        s = binary_search_compare_to(k, s, mid, comp);
        return s | kExactMatch;
      }
    }
    return s;
  }

  // Inserts the value x at position i, shifting all existing values and
  // children at positions >= i to the right by 1.
  void insert_value(int i, const value_type &x);

  // Removes the value at position i, shifting all existing values and children
  // at positions > i to the left by 1.
  void remove_value(int i);

  // Rebalances a node with its right sibling.
  void rebalance_right_to_left(btree_node *sibling, int to_move);
  void rebalance_left_to_right(btree_node *sibling, int to_move);

  // Splits a node, moving a portion of the node's values to its right sibling.
  void split(btree_node *sibling, int insert_position);

  // Merges a node with its right sibling, moving all of the values and the
  // delimiting key in the parent node onto itself.
  void merge(btree_node *sibling);

  // Swap the contents of "this" and "src".
  void swap(btree_node *src);

  // Node allocation/deletion routines.
  
  void destroy() {
    for (int i = 0; i < count(); ++i) {
      value_destroy(i);
    }
  }

 private:
  void value_init(int i) {
    new (&fields_.values[i]) mutable_value_type;
  }
  void value_init(int i, const value_type &x) {
    new (&fields_.values[i]) mutable_value_type(x);
  }
  void value_destroy(int i) {
    fields_.values[i].~mutable_value_type();
  }

 private:
  root_fields fields_;

 private:
  btree_node(const btree_node&);
  void operator=(const btree_node&);
};
*/
