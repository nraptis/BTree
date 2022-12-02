//
//  BTree.swift
//  TreeTests
//
//  Created by Nicky Taylor on 11/25/22.
//

import Foundation

class BTree<Element: Comparable> {
    
    let order: Int
    private let minOrder: Int
    
    var root: BTreeNode<Element>? = nil
    
    //private var height = 0
    private(set) var count = 0
    
    required init(order: Int) {
        guard order >= 3 else {
            fatalError("BTree.init(order:) order (\(order)) must be >= 3")
        }
        self.order = order
        self.minOrder = (order >> 1)
    }
    
    func isEmpty() -> Bool {
        return root === nil
    }
    
    func begin() -> BTreeIterator<Element> {
        BTreeIterator<Element>(node: root?.parent, index: 0)
    }
    
    func end() -> BTreeIterator<Element> {
        if let node = root?.rightmost {
            return BTreeIterator<Element>(node: node, index: node.count)
        } else {
            return BTreeIterator<Element>(node: nil, index: 0)
        }
    }
    
    /*
    func rightmost() -> BTreeNode<Element>? {
        guard let root = root else {
            return nil
        }
        if root.isLeaf {
            return root
        }
        return root.data.rightmost
    }
    
    func leftMost() -> BTreeNode<Element>? {
        guard let root = root else {
            return nil
        }
        if root.isLeaf {
            return root
        }
        return root.data.leftmost
    }
    */
    
    func delete_leaf_node(node: BTreeNode<Element>) {
        node.destroy()
    }
    
    //void btree<P>::rebalance_or_split(iterator *iter) {
    func rebalance_or_split(iterator: BTreeIterator<Element>) {
        
        //node_type *&node = iter->node;
        guard var node = iterator.node else {
            fatalError("BTree.rebalance_or_split() iterator.node is null")
        }
        
        //int &insert_position = iter->position;
        var insert_position = iterator.index
        
        //assert(node->count() == node->max_count());
        guard node.count == node.order else {
            fatalError("BTree.rebalance_or_split() node.count (\(node.count)) != node.order (\(node.order))")
        }

        // First try to make room on the node by rebalancing.
        //node_type *parent = node->parent();
        guard var parent = node.parent else {
            fatalError("BTree.rebalance_or_split() node.parent is null")
        }
        
        //if (node != root()) {
        if node != root {
            
            //if (node->position() > 0) {
            if node.index > 0 {
                // Try rebalancing with our left sibling.
                //node_type *left = parent->child(node->position() - 1);
                guard let left = parent.child(index: node.index - 1) else {
                    fatalError("BTree.rebalance_or_split() left null node.index (\(node.index)) - 1")
                }
                
                
                //if (left->count() < left->max_count()) {
                if left.count < left.order {
                
                    // We bias rebalancing based on the position being inserted. If we're
                    // inserting at the end of the right node then we bias rebalancing to
                    // fill up the left node.
                    //int to_move = (left->max_count() - left->count()) / (1 + (insert_position < left->max_count()));
                    
                    var denom = 1
                    if insert_position < left.order {
                        denom += 1
                    }
                    var to_move = (left.order - left.count) / denom
                    
                    //to_move = std::max(1, to_move);
                    if to_move < 1 {
                        to_move = 1
                    }
                    

                    //if (((insert_position - to_move) >= 0) ||
                    //((left->count() + to_move) < left->max_count())) {
                    
                    if ((insert_position - to_move) >= 0) || ((left.count + to_move) < left.order) {
                        
                        //left->rebalance_right_to_left(node, to_move);
                        left.rebalance_right_to_left(src: node, to_move: to_move)

                        //assert(node->max_count() - node->count() == to_move);
                        guard (node.order - node.count) == to_move else {
                            fatalError("BTree.rebalance_or_split() (node.order (\(node.order)) - node.count (\(node.count)) != to_move (\(to_move))")
                        }
                        
                        //insert_position = insert_position - to_move;
                        insert_position -= to_move
                        
                        //if (insert_position < 0) {
                        if insert_position < 0 {
                        
                            //insert_position = insert_position + left->count() + 1;
                            insert_position = insert_position + left.count + 1
                            
                            //node = left;
                            node = left
                            
                        }

                        //assert(node->count() < node->max_count());
                        guard node.count < node.order else {
                            fatalError("BTree.rebalance_or_split() node.count (\(node.count)) >= node.order (\(node.order))")
                        }
                        
                        //Update the iterator
                        iterator.node = node
                        
                        iterator.index = insert_position
                        
                        
                        return
                    }
                }
            }

            
            
            //if (node->position() < parent->count()) {
            if node.index < parent.count {
            
                // Try rebalancing with our right sibling.
                //node_type *right = parent->child(node->position() + 1);
                //var right = parent.child(index: node.index + 1)
                guard let right = parent.child(index: node.index + 1) else {
                    fatalError("BTree.rebalance_or_split() right null node.index (\(node.index)) + 1")
                }
                
                //if (right->count() < right->max_count()) {
                if right.count < right.order {
                    
                    
                    // We bias rebalancing based on the position being inserted. If we're
                    // inserting at the beginning of the left node then we bias rebalancing
                    // to fill up the right node.
                    
                    //int to_move = (right->max_count() - right->count()) /
                    //(1 + (insert_position > 0));
                
                    var denom = 1
                    if insert_position > 0 {
                        denom += 1
                    }
                    var to_move = (right.order - right.count) / (denom)
                
                    //to_move = std::max(1, to_move);
                    if to_move < 1 {
                        to_move = 1
                    }
                    
                    //if ((insert_position <= (node->count() - to_move)) ||
                    //    ((right->count() + to_move) < right->max_count())) {
                    if (insert_position <= (node.count - to_move)) || ((right.count + to_move) < right.order) {
                        
                        //node->rebalance_left_to_right(right, to_move);
                        node.rebalance_left_to_right(dest: right, to_move: to_move)
                        
                        //if (insert_position > node->count()) {
                        if insert_position > node.count {
                        
                            //insert_position = insert_position - node->count() - 1;
                            insert_position = insert_position - node.count - 1;
                            
                            //node = right;
                            node = right
                            
                        }
                        
                        //assert(node->count() < node->max_count());
                        guard node.count < node.order else {
                            fatalError("BTree.rebalance_or_split() node.count (\(node.count)) >= node.order (\(node.order))")
                        }
                        
                        //Update the iterator
                        iterator.node = node
                        iterator.index = insert_position
                        
                        return
                    }
                }
            }
            
            
            // Rebalancing failed, make sure there is room on the parent node for a new
            // value.
            
            //if (parent->count() == parent->max_count()) {
            if parent.count == parent.order {
                //iterator parent_iter(node->parent(), node->position());
                let parentIterator = BTreeIterator<Element>(node: node.parent, index: node.index)
                
                //rebalance_or_split(&parent_iter);
                rebalance_or_split(iterator: parentIterator)
            }
            
        } else {
            
            guard let root = root else {
                fatalError("BTree.rebalance_or_split() root is null")
            }
            
            // Rebalancing not possible because this is the root node.
            //if (root()->leaf()) {
            if root.isLeaf {
                
                /*
                // The root node is currently a leaf node: create a new root node and set
                // the current root node as the child of the new root.
                parent = new_internal_root_node();
                parent->set_child(0, root());
                *mutable_root() = parent;
                assert(*mutable_rightmost() == parent->child(0));
                */
                
                // The root node is currently a leaf node: create a new root node and set
                // the current root node as the child of the new root.
                //parent = new_internal_root_node();
                parent = new_internal_root_node()
                root.isRoot = false
                
                //parent->set_child(0, root());
                parent.set_child(i: 0, node: root)
                
                //*mutable_root() = parent;
                self.root = parent
                
                //assert(*mutable_rightmost() == parent->child(0));
                guard parent.rightmost == parent.child(index: 0) else {
                    fatalError("BTree.rebalance_or_split() rightmost() != parent.child(index: 0)")
                }
                
            } else {
                // The root node is an internal node. We do not want to create a new root
                // node because the root node is special and holds the size of the tree
                // and a pointer to the rightmost node. So we create a new internal node
                // and move all of the items on the current root into the new node.
                
                //parent = new_internal_node(parent);
                parent = BTreeNode<Element>.createInternal(order: order, parent: parent)
                //parent.leftmost = root.leftmost
                //parent.rightmost = root.rightmost
                
                
                //parent->set_child(0, parent);
                parent.set_child(i: 0, node: parent)
                
                //parent->swap(root());
                parent.swap(node: root)
                
                //node = parent;
                node = parent
            }
            
        }

        
        // Split the node.
        //node_type *split_node;
        
        //if (node->leaf()) {
        if node.isLeaf {
            
            guard let root = root else {
                fatalError("BTree.rebalance_or_split() root is null")
            }
        
            //split_node = new_leaf_node(parent);
            let split_node = new_leaf_node(parent: parent)
            
            //node->split(split_node, insert_position);
            node.split(dest: split_node, insert_position: insert_position)
            
            //if (rightmost() == node) {
            //    *mutable_rightmost() = split_node;
            //}
            if root.rightmost === node {
                //rightmost = split_node
                root.rightmost = split_node
            }
            
            if insert_position > node.count {
                insert_position = insert_position - node.count - 1
                node = split_node
            }
        } else {
            //split_node = new_internal_node(parent);
            let split_node = BTreeNode<Element>.createInternal(order: order, parent: parent)
            
            //node->split(split_node, insert_position);
            node.split(dest: split_node, insert_position: insert_position)
            
            if insert_position > node.count {
                insert_position = insert_position - node.count - 1
                node = split_node
            }
        }

        //Update the iterator
        iterator.node = node
        iterator.index = insert_position
        
    }
    
    //iterator internal_end(iterator iter) {
    private func internal_end(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        //return iter.node ? iter : end();
        if iterator.node != nil {
            return iterator
        } else {
            return end()
        }
    }
    
    
    func contains(_ element: Element) -> Bool {
        let rootIterator = BTreeIterator(node: root, index: 0)
        let iterator = internal_find_multi(iterator: rootIterator, element: element)
        return iterator.node != nil
    }
    
    func countElement(_ element: Element) -> Int {
        let lowerBound = lower_bound(element: element)
        let upperBound = upper_bound(element: element)
        return distance(iterator1: lowerBound, iterator2: upperBound)
    }
    
    /*
    size_type count_multi(const key_type &key) const {
      return distance(lower_bound(key), upper_bound(key));
    }
    */
    
    //@discardableResult
    func insert(_ element: Element) {
        
        //if (empty()) {
        //  *mutable_root() = new_leaf_root_node(1);
        //}
        if isEmpty() {
            self.root = new_leaf_root_node()
        }
        
        guard let root = root else {
            fatalError("BTree.insert(_ element: Element) root is null")
        }
        
        //iterator iter = internal_upper_bound(key, iterator(root(), 0));
        let rootIterator = BTreeIterator(node: root, index: 0)
        var iterator = internal_upper_bound(iterator: rootIterator, element: element)
        
        //TODO: upper bound...
        
        //if (!iter.node) {
        //    iter = end();
        //}
        if iterator.node == nil {
            iterator = end()
        }
        
        //return internal_insert(iter, *value);
        //return
        insert(iterator: iterator, element: element)
    }
    
    
    //need funcs:
    // tree::delete_leaf_node
    // tree::rebalance_or_split
    
    /*
    //inline typename btree<P>::iterator btree<P>::internal_insert(iterator iter, const value_type &v) {
    private func insert(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        
        guard let node = iterator.node else {
            
        }
        
        if (!iter.node->leaf()) {
            // We can't insert on an internal node. Instead, we'll insert after the
            // previous value which is guaranteed to be on a leaf node.
            --iter;
            ++iter.position;
        }
        if (iter.node->count() == iter.node->max_count()) {
            // Make room in the leaf for the new item.
            if (iter.node->max_count() < kNodeValues) {
                // Insertion into the root where the root is smaller that the full node
                // size. Simply grow the size of the root node.
                assert(iter.node == root());
                iter.node = new_leaf_root_node(
                    std::min<int>(kNodeValues, 2 * iter.node->max_count()));
                iter.node->swap(root());
                delete_leaf_node(root());
                *mutable_root() = iter.node;
            } else {
                rebalance_or_split(&iter);
                ++*mutable_size();
            }
            
        } else if (!root()->leaf()) {
            ++*mutable_size();
        }
        iter.node->insert_value(iter.position, v);
        return iter;
    }
    */
    
    //btree<P>::internal_insert(iterator iter, const value_type &v) {
    @discardableResult
    private func insert(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        
        guard var node = iterator.node else {
            fatalError("insert(iterator: BTreeIterator<Element>, element: Element) iterator.node is null (I)")
        }
        
        //if (!iter.node->leaf()) {
        if !node.isLeaf {
            // We can't insert on an internal node. Instead, we'll insert after the
            // previous value which is guaranteed to be on a leaf node.
            //--iter;
            iterator.decrement()
            //++iter.position;
            iterator.index += 1
        }
        
        guard var node = iterator.node else {
            fatalError("insert(iterator: BTreeIterator<Element>, element: Element) iterator.node is null (II)")
        }
        
        //if (iter.node->count() == iter.node->max_count()) {
        if node.count == node.order {
            //rebalance_or_split(&iter);
            rebalance_or_split(iterator: iterator)
            
            //++*mutable_size();
            count += 1
            //} else if !root.isLeaf {
        } else {
            //++*mutable_size();
            count += 1
        }
        
        guard var node = iterator.node else {
            fatalError("BTree.insert(iterator: BTreeIterator<Element>, element: Element) iterator.node is null (II)")
        }
        
        //iter.node->insert_value(iter.position, v);
        node.insert_value(index: iterator.index, element: element)
        
        //return iter;
        return iterator
    }
    
    func remove(_ element: Element) {
        let begin = internal_lower_bound(iterator: BTreeIterator(node: root, index: 0), element: element)
        if begin.node == nil {
            return
        }
        let upperBnd = internal_upper_bound(iterator: BTreeIterator(node: root, index: 0), element: element)
        let end = internal_end(iterator: upperBnd)
        //print("Delete from \(begin.node!.name) (\(begin.index)) to \(end.node!.name) (\(end.index))")
        _ = remove(startIterator: begin, endIterator: end)
    }
    /*
    int btree<P>::erase_multi(const key_type &key) {
        
    }
    */
    
    /*
    typename btree<P>::iterator btree<P>::erase(iterator iter) {
        bool internal_delete = false;
        
        if (!iter.node->leaf()) {
            
            iterator tmp_iter(iter--);
            assert(iter.node->leaf());
            assert(!compare_keys(tmp_iter.key(), iter.key()));
            iter.node->value_swap(iter.position, tmp_iter.node, tmp_iter.position);
            internal_delete = true;
            --*mutable_size();
        } else if (!root()->leaf()) {
            --*mutable_size();
        }
        
        iter.node->remove_value(iter.position);

        iterator res(iter);
        for (;;) {
            if (iter.node == root()) {
                try_shrink();
                if (empty()) {
                    return end();
                }
                break;
            }
            if (iter.node->count() >= kMinNodeValues) {
                break;
            }
            bool merged = try_merge_or_rebalance(&iter);
            if (iter.node->leaf()) {
                res = iter;
            }
            if (!merged) {
                break;
            }
            iter.node = iter.node->parent();
        }
     
        if (res.position == res.node->count()) {
        res.position = res.node->count() - 1;
            ++res;
        }
        if (internal_delete) {
            ++res;
        }
        return res;
    }
    */
    
    func remove(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        
        /*
        bool internal_delete = false;
        
        if (!iter.node->leaf()) {
            
            iterator tmp_iter(iter--);
            assert(iter.node->leaf());
            assert(!compare_keys(tmp_iter.key(), iter.key()));
            iter.node->value_swap(iter.position, tmp_iter.node, tmp_iter.position);
            internal_delete = true;
            --*mutable_size();
        } else if (!root()->leaf()) {
            --*mutable_size();
        }
        */
        
        var internal_delete = false
        
        if let node = iterator.node {
            if !node.isLeaf {
                let tmp_iter = BTreeIterator(iterator: iterator)
                let tempNode = node
                iterator.decrement()
                guard let iteratorNode = iterator.node else {
                    fatalError("BTree.remove(iterator: BTreeIterator<Element>) iterator.node is null (II)")
                }
                guard iteratorNode.isLeaf else {
                    fatalError("BTree.remove(iterator: BTreeIterator<Element>) node.isLeaf is false")
                }
                /*
                guard iteratorNode.value(index: iterator.index) == tempNode.value(index: tmp_iter.index) else {
                    fatalError("BTree.remove(iterator: BTreeIterator<Element>) tmp_iter.value() (\(String(describing: iteratorNode.value(index: iterator.index))) != iterator.value() (\(String(describing: tempNode.value(index: tmp_iter.index))))")
                }
                */
                iteratorNode.value_swap(i: iterator.index, x: tempNode, j: tmp_iter.index)
                internal_delete = true
                count -= 1
            } else {
                count -= 1
            }
        }
        
        //iter.node->remove_value(iter.position);
        
        if let node = iterator.node {
            //print("node \(node.name) pre-delete (\(iterator.index)) \(node.data.values)")
            node.remove_value(index: iterator.index)
            //print("node \(node.name) post-delete (\(iterator.index)) \(node.data.values)")
        }

        /*
        iterator res(iter);
        for (;;) {
            if (iter.node == root()) {
                try_shrink();
                if (empty()) {
                    return end();
                }
                break;
            }
            if (iter.node->count() >= kMinNodeValues) {
                break;
            }
            bool merged = try_merge_or_rebalance(&iter);
            if (iter.node->leaf()) {
                res = iter;
            }
            if (!merged) {
                break;
            }
            iter.node = iter.node->parent();
        }
        */
        
        var result = BTreeIterator(iterator: iterator)
        while var node = iterator.node {
            if node === root {
                
                //print("pre-shrink...")
                //printLevels()
                
                try_shrink()
                
                //print("post-shrink...")
                //printLevels()
                
                if self.root == nil {
                    return end()
                }
                
                break
            }
            if node.count >= minOrder {
                break
            }
            
            //print("pre-merged...")
            //printLevels()
            
            let merged = try_merge_or_rebalance(iterator: iterator)
            
            //print("post-merged...")
            //printLevels()
            
            if node.isLeaf {
                result.set(iterator: iterator)
            }
            if !merged {
                break
            }
            
            iterator.node = iterator.node?.parent
        }

        // Adjust our return value. If we're pointing at the end of a node, advance
        // the iterator.
        
        guard let node = result.node else {
            fatalError("BTree.remove(iterator: BTreeIterator<Element>) result.node is null")
        }
        
        //if (res.position == res.node->count()) {
        if result.index == node.count {
            //res.position = res.node->count() - 1;
            result.index = (node.count - 1)
            
            //++res;
            result.increment()
        }
        
        // If we erased from an internal node, advance the iterator.
        /*
        if (internal_delete) {
            ++res;
        }
        return res;
        */
        if internal_delete {
            result.increment()
        }
        return result
    }
    
     
    /*
    template <typename P>
    int btree<P>::erase(iterator begin, iterator end) {
        int count = distance(begin, end);
        for (int i = 0; i < count; i++) {
            begin = erase(begin);
        }
        return count;
    }
    */
    
    func remove(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) -> Int {
        var iterator = BTreeIterator<Element>(iterator: startIterator)
        let count = distance(iterator1: startIterator, iterator2: endIterator)
        for _ in 0..<count {
            iterator = remove(iterator: iterator)
        }
        return count
    }
    
    
    /*
    void btree<P>::merge_nodes(node_type *left, node_type *right) {
        left->merge(right);
        if (right->leaf()) {
            if (rightmost() == right) {
                *mutable_rightmost() = left;
            }
            delete_leaf_node(right);
        } else {
            delete_internal_node(right);
        }
    }
    */
    
    func merge_nodes(left: BTreeNode<Element>, right: BTreeNode<Element>) {
        
        /*
        print("pre left.merge(right) left \(left.name) \(left.data.values) count \(left.data.count)")
        print("pre left.merge(right) right \(right.name) \(right.data.values) count \(right.data.count)")
        print("pre left.merge(right) l_parent \(left.parent!.name) \(left.parent!.data.values) count \(left.parent!.data.count)")
        print("pre left.merge(right) r_parent \(right.parent!.name) \(right.parent!.data.values) count \(right.parent!.data.count)")
        */
         
        left.merge(source: right)
        
        /*
        print("post left.merge(right) left \(left.name) \(left.data.values) count \(left.data.count)")
        print("post left.merge(right) right \(right.name) \(right.data.values) count \(right.data.count)")
        print("post left.merge(right) l_parent \(left.parent!.name) \(left.parent!.data.values) count \(left.parent!.data.count)")
        print("post left.merge(right) r_parent \(right.parent!.name) \(right.parent!.data.values) count \(right.parent!.data.count)")
        */
         
        if right.isLeaf {
            if let root = root, root.rightmost == right {
                root.rightmost = left
            }
            delete_leaf_node(node: right)
        } else {
            delete_internal_node(right)
        }
    }
    
    
    /*
    bool btree<P>::try_merge_or_rebalance(iterator *iter) {
        node_type *parent = iter->node->parent();
        if (iter->node->position() > 0) {
            node_type *left = parent->child(iter->node->position() - 1);
            if ((1 + left->count() + iter->node->count()) <= left->max_count()) {
                iter->position += 1 + left->count();
                merge_nodes(left, iter->node);
                iter->node = left;
                return true;
            }
        }
        if (iter->node->position() < parent->count()) {
            node_type *right = parent->child(iter->node->position() + 1);
            if ((1 + iter->node->count() + right->count()) <= right->max_count()) {
                merge_nodes(iter->node, right);
                return true;
            }
            if ((right->count() > kMinNodeValues) &&
            ((iter->node->count() == 0) ||
            (iter->position > 0))) {
                int to_move = (right->count() - iter->node->count()) / 2;
                to_move = std::min(to_move, right->count() - 1);
                iter->node->rebalance_right_to_left(right, to_move);
                return false;
            }
        }
        
        if (iter->node->position() > 0) {
            node_type *left = parent->child(iter->node->position() - 1);
            if ((left->count() > kMinNodeValues) &&
            ((iter->node->count() == 0) ||
            (iter->position < iter->node->count()))) {
                int to_move = (left->count() - iter->node->count()) / 2;
                to_move = std::min(to_move, left->count() - 1);
                left->rebalance_left_to_right(iter->node, to_move);
                iter->position += to_move;
                return false;
            }
        }
        return false;
    }
    */
    func try_merge_or_rebalance(iterator: BTreeIterator<Element>) -> Bool {
        /*
        node_type *parent = iter->node->parent();
        if (iter->node->position() > 0) {
            node_type *left = parent->child(iter->node->position() - 1);
            if ((1 + left->count() + iter->node->count()) <= left->max_count()) {
                iter->position += 1 + left->count();
                merge_nodes(left, iter->node);
                iter->node = left;
                return true;
            }
        }
        */
        
        guard let parent = iterator.node?.parent else {
            fatalError("BTree.try_merge_or_rebalance() iterator.node?.parent is nil node: \(String(describing: iterator.node)) parent: \(String(describing: iterator.node?.parent))")
        }
        
        if let node = iterator.node {
            if node.index > 0 {
                guard let left = parent.child(index: node.index - 1) else {
                    fatalError("BTree.try_merge_or_rebalance() parent.child(index: node.index (\(node.index)) - 1) is nil")
                }
                if (1 + left.count + node.count) <= left.order {
                    iterator.index += (1 + left.count)
                    merge_nodes(left: left, right: node)
                    iterator.node = left
                    return true
                }
            }
        }

        /*
        if (iter->node->position() < parent->count()) {
            node_type *right = parent->child(iter->node->position() + 1);
            if ((1 + iter->node->count() + right->count()) <= right->max_count()) {
                merge_nodes(iter->node, right);
                return true;
            }
            if ((right->count() > kMinNodeValues) &&
            ((iter->node->count() == 0) ||
            (iter->position > 0))) {
                int to_move = (right->count() - iter->node->count()) / 2;
                to_move = std::min(to_move, right->count() - 1);
                iter->node->rebalance_right_to_left(right, to_move);
                return false;
            }
        }
        */
        
        if let node = iterator.node {
            if node.index < parent.count {
                guard let right = parent.child(index: node.index + 1) else {
                    fatalError("BTree.try_merge_or_rebalance() parent.child(index: node.index (\(node.index)) + 1) is nil")
                }
                if (1 + node.count + right.count) <= right.order {
                    
                    //print("pre-merge_nodes left: \(node.name) \(node.data.values)")
                    //print("pre-merge_nodes right: \(right.name) \(right.data.values)")
                    //printLevels()
                    
                    merge_nodes(left: node, right: right)
                    
                    //print("post-merge_nodes left: \(node.name) \(node.data.values)")
                    //print("post-merge_nodes right: \(right.name) \(right.data.values)")
                    //print("post-merge_nodes")
                    //printLevels()
                    
                    return true
                }
                var cond1 = right.count > minOrder
                var cond2 = node.count == 0
                var cond3 = node.index > 0
                
                if cond1 && (cond2 || cond3) {
                    var to_move = (right.count - node.count) >> 1
                    if to_move > (right.count - 1) {
                        to_move = (right.count - 1)
                    }
                    node.rebalance_right_to_left(src: right, to_move: to_move)
                    return false
                }
            }
        }
        
        if let node = iterator.node {
            if node.index > 0 {
                // Try rebalancing with our left sibling. We don't perform rebalancing if
                // we deleted the last element from iter->node and the node is not
                // empty. This is a small optimization for the common pattern of deleting
                // from the back of the tree.
                
                //node_type *left = parent->child(iter->node->position() - 1);
                guard let left = parent.child(index: node.index - 1) else {
                    fatalError("BTree.try_merge_or_rebalance() parent.child(index: node.index (\(node.index)) - 1) is nil")
                }
                
                
                //if ((left->count() > kMinNodeValues) &&
                //((iter->node->count() == 0) || (iter->position < iter->node->count()))) {
                let cond1 = left.count > minOrder
                let cond2 = node.count == 0
                let cond3 = iterator.index < node.count
                if cond1 && (cond2 || cond3) {
                    
                    //int to_move = (left->count() - iter->node->count()) / 2;
                    var to_mode = (left.count - node.count) >> 1
                    
                    //to_move = std::min(to_move, left->count() - 1);
                    if to_mode > (left.count - 1) {
                        to_mode = (left.count - 1)
                    }
                    
                    //left->rebalance_left_to_right(iter->node, to_move);
                    left.rebalance_left_to_right(dest: node, to_move: to_mode)
                    
                    //iter->position += to_move;
                    iterator.index += to_mode
                    //return false;
                    return false
                }
            }
        }
        //return false;
        return false
    }
    
    
    
    /*
    void btree<P>::try_shrink() {
        if (root()->count() > 0) {
            return;
        }
        if (root()->leaf()) {
            assert(size() == 0);
            delete_leaf_node(root());
            *mutable_root() = NULL;
        } else {
            node_type *child = root()->child(0);
            if (child->leaf()) {
                child->make_root();
                delete_internal_root_node();
                *mutable_root() = child;
            } else {
                child->swap(root());
                delete_internal_node(child);
            }
        }
    }
    */
    
    func try_shrink() {
        guard let root = root, root.count <= 0 else {
            return
        }
        if root.isLeaf {
            delete_leaf_node(node: root)
            self.root = nil
        } else {
            guard let child = root.child(index: 0) else {
                fatalError("BTree.try_shrink() root.child(index: 0) is nil")
            }
            if child.isLeaf {
                child.make_root()
                //child.rightmost = root.rightmost //TODO: Needed?
                delete_internal_root_node()
                self.root = child
                
            } else {
                child.swap(node: root)
                delete_internal_node(child)
            }
        }
    }
    
    
    //void delete_leaf_node(node_type *node) {
    func delete_leaf_node(_ node: BTreeNode<Element>) {
        //node->destroy();
        
        guard node.isLeaf else {
            fatalError("BTree.delete_leaf_node() node.isLeaf (\(node.isLeaf)) should be true")
        }
        
        node.destroy()
        
        //mutable_internal_allocator()->deallocate(
        //reinterpret_cast<char*>(node),
        //sizeof(base_fields) + node->max_count() * sizeof(value_type));
    }
    
    //void delete_internal_node(node_type *node) {
    func delete_internal_node(_ node: BTreeNode<Element>) {
    
        //node->destroy();
        node.destroy()
        
        //assert(node != root());
        guard node !== root else {
            fatalError("BTree.delete_internal_node() node === root")
        }
        
        //mutable_internal_allocator()->deallocate(
        //reinterpret_cast<char*>(node), sizeof(internal_fields));
    }
    
    
    //void delete_internal_root_node() {
    func delete_internal_root_node() {
        //root()->destroy();
        if let root = root {
            root.destroy()
            root.isRoot = false
        }
        
        //mutable_internal_allocator()->deallocate(
        //reinterpret_cast<char*>(root()), sizeof(root_fields));
        
    }
    
    //inline IterType btree<P>::internal_last(IterType iter) {
    func internal_last(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
     
        //while (iter.node && iter.position == iter.node->count()) {
        while let node = iterator.node, iterator.index == node.count {
            //iter.position = iter.node->position();
            iterator.index = node.index
            //iter.node = iter.node->parent();
            iterator.node = node.parent
            //if (iter.node->leaf()) {
            if let node = iterator.node {
                if node.isLeaf {
                    //iter.node = NULL;
                    iterator.node = nil
                }
            }
        }
        //return iter;
        
        return iterator
    }
    
    // Finds the first element whose key is not less than key.
    //iterator lower_bound(const key_type &key) {
    func lower_bound(element: Element) -> BTreeIterator<Element> {
        let rootIterator = BTreeIterator(node: root, index: 0)
        
        let lowerBound = internal_lower_bound(iterator: rootIterator, element: element)
        let result = internal_end(iterator: lowerBound)
        return result
    }
    
    // Finds the first element whose key is greater than key.
    func upper_bound(element: Element) -> BTreeIterator<Element> {
        let rootIterator = BTreeIterator(node: root, index: 0)
        let upperBound = internal_upper_bound(iterator: rootIterator, element: element)
        let result = internal_end(iterator: upperBound)
        return result
    }
    
    func distance(iterator1: BTreeIterator<Element>, iterator2: BTreeIterator<Element>) -> Int {
        if iterator1 == iterator2 {
            return 0
        } else {
            var result = 0
            var iterator = BTreeIterator<Element>(iterator: iterator1)
            while iterator != iterator2 {
                iterator.increment()
                result += 1
            }
            return result
        }
    }
    
    
    
    //template <typename P> template <typename IterType>
    //IterType btree<P>::internal_find_multi(
    //const key_type &key, IterType iter) const {
    func internal_find_multi(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        //if (iter.node) {
        var iterator = iterator
        if iterator.node != nil {
            //iter = internal_lower_bound(key, iter);
            iterator = internal_lower_bound(iterator: iterator, element: element)
            
            //if (iter.node) {
            if iterator.node != nil {
                //iter = internal_last(iter);
                iterator = internal_last(iterator: iterator)
                
                //if (iter.node && !compare_keys(key, iter.key())) {
                if let node = iterator.node, node.value(index: iterator.index) == element {
                
                    //return iter;
                    return iterator
                }
            }
        }
        //return IterType(NULL, 0);
        return BTreeIterator<Element>(node: nil, index: 0)
    }
    
    
    //IterType btree<P>::internal_lower_bound(
    //const key_type &key, IterType iter) const {
    func internal_lower_bound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        //if (iter.node) {
        var iterator = iterator
        if iterator.node != nil {
            while let node = iterator.node {
            //for (;;) {
                //iter.position = iter.node->lower_bound(key, key_comp()) & kMatchMask;
                iterator.index = node.lowerBound(element: element)
                
                //if (iter.node->leaf()) {
                //    break;
                //}
                if node.isLeaf {
                    break
                }
                
                //iter.node = iter.node->child(iter.position);
                iterator.node = node.child(index: iterator.index)
            }
            //iter = internal_last(iter);
            iterator = internal_last(iterator: iterator)
        }
        //return iter;
        return iterator
    }
    
    /*
    IterType btree<P>::internal_upper_bound(const key_type &key, IterType iter) const {
        if (iter.node) {
            for (;;) {
                iter.position = iter.node->upper_bound(key, key_comp());
                if (iter.node->leaf()) {
                    break;
                }
                iter.node = iter.node->child(iter.position);
            }
            iter = internal_last(iter);
        }
        return iter;
    }
    */
    
    func internal_upper_bound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        //if (iter.node) {
        //for (;;) {
        var iterator = iterator
        if iterator.node != nil {
            while let node = iterator.node {
                //iter.position = iter.node->upper_bound(key, key_comp());
                iterator.index = node.upperBound(element: element)
                
                //if (iter.node->leaf()) {
                if node.isLeaf {
                    //break;
                    break
                    
                }
                
                //iter.node = iter.node->child(iter.position);
                iterator.node = node.child(index: iterator.index)
            }
            iterator = internal_last(iterator: iterator)
        }
        //iter = internal_last(iter);
        //return iter;
        return iterator
    }
    
    
    /*
    / Node creation/deletion routines.
    node_type* new_internal_node(node_type *parent) {
      internal_fields *p = reinterpret_cast<internal_fields*>(
          mutable_internal_allocator()->allocate(sizeof(internal_fields)));
      return node_type::init_internal(p, parent);
    }
    */
    func new_internal_node(parent: BTreeNode<Element>) -> BTreeNode<Element> {
        let result = BTreeNode<Element>.createInternal(order: order, parent: parent)
        return result
    }
    
    /*
    node_type* new_internal_root_node() {
      root_fields *p = reinterpret_cast<root_fields*>(
          mutable_internal_allocator()->allocate(sizeof(root_fields)));
      return node_type::init_root(p, root()->parent());
    }
    */
    func new_internal_root_node() -> BTreeNode<Element> {
        guard let parent = root?.parent else {
            fatalError("BTree.new_internal_root_node root?.parent is null")
        }
        let result = BTreeNode<Element>.createRootInternal(order: order, parent: parent)
        return result
    }
    
    /*
    node_type* new_leaf_node(node_type *parent) {
      leaf_fields *p = reinterpret_cast<leaf_fields*>(
          mutable_internal_allocator()->allocate(sizeof(leaf_fields)));
      return node_type::init_leaf(p, parent, kNodeValues);
    }
    */
    func new_leaf_node(parent: BTreeNode<Element>) -> BTreeNode<Element> {
        let result = BTreeNode<Element>.createLeaf(order: order, parent: parent)
        return result
    }
    
    /*
    node_type* new_leaf_root_node(int max_count) {
      leaf_fields *p = reinterpret_cast<leaf_fields*>(
          mutable_internal_allocator()->allocate(
              sizeof(base_fields) + max_count * sizeof(value_type)));
      return node_type::init_leaf(p, reinterpret_cast<node_type*>(p), max_count);
    }
    */
    func new_leaf_root_node() -> BTreeNode<Element> {
        let result = BTreeNode<Element>.createRootLeaf(order: order)
        return result
    }
    
    
    /*
     template <typename P> template <typename ValuePointer>
     typename btree<P>::iterator
     btree<P>::insert_multi(const key_type &key, ValuePointer value) {
       
     }

     template <typename P>
     typename btree<P>::iterator
     btree<P>::insert_multi(iterator position, const value_type &v) {
       if (!empty()) {
         const key_type &key = params_type::key(v);
         if (position == end() || !compare_keys(position.key(), key)) {
           iterator prev = position;
           if (position == begin() || !compare_keys(key, (--prev).key())) {
             // prev.key() <= key <= position.key()
             return internal_insert(position, v);
           }
         } else {
           iterator next = position;
           ++next;
           if (next == end() || !compare_keys(next.key(), key)) {
             // position.key() < key <= next.key()
             return internal_insert(next, v);
           }
         }
       }
       return insert_multi(v);
     }

     template <typename P> template <typename InputIterator>
     void btree<P>::insert_multi(InputIterator b, InputIterator e) {
       for (; b != e; ++b) {
         insert_multi(end(), *b);
       }
     }

    */
    
    /*
    func internal_upper_bound(_ element: Element, iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        //if (iter.node) {
        
        for (;;) {
            
            
            iter.position = iter.node->upper_bound(key, key_comp());
            
            if (iter.node->leaf()) {
                
                break;
                
            }
            
            iter.node = iter.node->child(iter.position);
            
        }
        
        iter = internal_last(iter);
        
    }
    
    return iter;
    */
    
    func setRoot(_ node: BTreeNode<Element>?) {
        self.root = node
        self.count = countValues(node)
        
        guard let node = node else {
            return
        }
        
        node.parent = findLeftMost(node)
        node.rightmost = findRightMost(node)
    }
    
    func findRightMost(_ node: BTreeNode<Element>?) -> BTreeNode<Element>? {
        guard let node = node else {
            return nil
        }
        if node.isLeaf {
            return node
        }
        if node.count <= 0 {
            fatalError("BTree.findRightMost(_ node: BTreeNode<Element>?) node has count of 0")
        }
        if let child = node.data.children[node.count] {
            return findRightMost(child)
        } else {
            fatalError("BTree.findRightMost(_ node: BTreeNode<Element>?) child expected at count")
            //return node
        }
    }
    
    func findLeftMost(_ node: BTreeNode<Element>?) -> BTreeNode<Element>? {
        guard let node = node else {
            return nil
        }
        if node.isLeaf {
            return node
        }
        if node.count <= 0 {
            fatalError("BTree.findLeftMost(_ node: BTreeNode<Element>?) node has count of 0")
        }
        if let child = node.data.children[0] {
            return findLeftMost(child)
        } else {
            fatalError("BTree.findLeftMost(_ node: BTreeNode<Element>?) child expected at 0")
            //return node
        }
    }
    
    func countValues() -> Int {
        countValues(root)
    }
    
    func countValues(_ node: BTreeNode<Element>?) -> Int {
        guard let node = node else {
            return 0
        }
        var result = node.count
        if !node.isLeaf {
            for index in 0...node.count {
                if let child = node.data.children[index] {
                    if child.isLeaf {
                        result += child.count
                    } else {
                        result += countValues(child)
                    }
                }
            }
        }
        return result
    }
    
    func maxDepth() -> Int {
        maxDepth(root)
    }
    
    func maxDepth(_ node: BTreeNode<Element>?) -> Int {
        guard let node = node else {
            return 0
        }
        var maxChildDepth = 0
        if !node.isLeaf {
            for index in 0...node.count {
                if let child = node.data.children[index] {
                    if child.isLeaf {
                        let childDepth = 1
                        if childDepth > maxChildDepth {
                            maxChildDepth = childDepth
                        }
                    } else {
                        let childDepth = maxDepth(child)
                        if childDepth > maxChildDepth {
                            maxChildDepth = childDepth
                        }
                    }
                }
            }
        }
        return maxChildDepth + 1
    }
    
    func allNodesAtEachLevel() -> [[BTreeNode<Element>]] {
        let treeDepth = maxDepth()
        var result = [[BTreeNode<Element>]](repeating: [BTreeNode<Element>](), count: treeDepth)
        
        for level in 0..<treeDepth {
            allNodesAtLevel(root, depth: 0, level: level, &result[level])
        }
        
        return result
    }
    
    func allNodesAtLevel(_ node: BTreeNode<Element>?, depth: Int, level: Int, _ result: inout [BTreeNode<Element>]) {
        guard let node = node else {
            return
        }
        if depth == level {
            result.append(node)
        } else if depth < level, !node.isLeaf {
            for index in 0...node.count {
                allNodesAtLevel(node.data.children[index], depth: depth + 1, level: level, &result)
            }
        }
    }
    
    func nodeValues(_ node: BTreeNode<Element>?) -> [Element] {
        guard let node = node else {
            return [Element]()
        }
        var result = [Element]()
        for i in 0..<node.count {
            if let value = node.data.values[i] {
                result.append(value)
            }
        }
        return result
    }
    
    func nameOfNode(_ node: BTreeNode<Element>, level: Int, nodes: [[BTreeNode<Element>]]) -> String {
        var index: Int = -1
        if level >= 0 && level < nodes.count {
            for (checkIndex, check) in nodes[level].enumerated() {
                if check === node {
                    index = checkIndex
                }
            }
        }
        
        var letter = "a"
        if level == 1 { letter = "b" }
        if level == 2 { letter = "c" }
        if level == 3 { letter = "d" }
        if level == 4 { letter = "e" }
        if level == 5 { letter = "f" }
        if level == 6 { letter = "g" }
        if level == 7 { letter = "h" }
        if level == 8 { letter = "i" }
        if level == 9 { letter = "j" }
        if level == 10 { letter = "k" }
        
        return "\(letter)-\(index)"
    }
    
    func printLevels() {
        let nodes = allNodesAtEachLevel()
        print("___Begin: Printing Tree (\(nodes.count) Levels)")
        
        var names = [BTreeNode<Element>: String]()
        
        for level in 0..<nodes.count {
            let list = nodes[level]
            print("_Level: \(level + 1)")
            for node in list {
                let values = nodeValues(node)
                if node.isRoot {
                    let name = nameOfNode(node, level: level, nodes: nodes)
                    names[node] = name
                    node.name = name
                    if node.isLeaf {
                        print("R|L {\(name)} (\(node.count) / \(node.order)) \(values)")
                    } else {
                        print("R|I {\(name)} (\(node.count) / \(node.order)) \(values)")
                    }
                } else {
                    let name = nameOfNode(node, level: level, nodes: nodes)
                    
                    var parentName = "nil"
                    if let parent = node.parent {
                        parentName = nameOfNode(parent, level: level - 1, nodes: nodes)
                    }
                    
                    names[node] = name
                    node.name = name
                    
                    if node.isLeaf {
                        print("N|L {\(name)} (\(node.count) / \(node.order)) \(values) in {\(parentName)}[\(node.index)]")
                    } else {
                        print("N|I {\(name)} (\(node.count) / \(node.order)) \(values) in {\(parentName)}[\(node.index)]")
                    }
                }
            }
            print("___\n")
        }
        
        if let lm = root?.parent {
            print("left most: \(names[lm] ?? "?")")
        }
        if let rm = root?.rightmost {
            print("right most: \(names[rm] ?? "?")")
        }
        
        print("___End: Printing Tree")
    }
    
}
