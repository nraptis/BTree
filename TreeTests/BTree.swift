//
//  BTree.swift
//  TreeTests
//
//  Created by Nicky Taylor on 11/25/22.
//

import Foundation

class BTree<Element: Comparable> {
    
    
    
    
    
    
    let order: Int
    //private
    var root: BTreeNode<Element>? = nil
    
    //private var height = 0
    private(set) var count = 0
    
    required init(order: Int) {
        self.order = order
    }
    
    func isEmpty() -> Bool {
        return root === nil
    }
    
    /*
     template <typename P> template <typename IterType>
     IterType btree<P>::internal_upper_bound(
     const key_type &key, IterType iter) const {
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
    
    /*
    // Iterator routines.
    iterator begin() {
      return iterator(leftmost(), 0);
    }
    const_iterator begin() const {
      
    }
    iterator end() {
      return iterator(rightmost(), rightmost() ? rightmost()->count() : 0);
    }
    const_iterator end() const {
      return const_iterator(rightmost(), rightmost() ? rightmost()->count() : 0);
    }
    reverse_iterator rbegin() {
      return reverse_iterator(end());
    }
    const_reverse_iterator rbegin() const {
      return const_reverse_iterator(end());
    }
    reverse_iterator rend() {
      return reverse_iterator(begin());
    }
    const_reverse_iterator rend() const {
      return const_reverse_iterator(begin());
    }
    */
    
    func begin() -> BTreeIterator<Element> {
        BTreeIterator<Element>(node: leftMost(), index: 0)
    }
    
    func end() -> BTreeIterator<Element> {
        if let node = rightmost() {
            return BTreeIterator<Element>(node: node, index: node.count)
        } else {
            return BTreeIterator<Element>(node: nil, index: 0)
        }
    }
    
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
    
    func delete_leaf_node(node: BTreeNode<Element>) {
        
    }
    
    func rebalance_or_split(iterator: BTreeIterator<Element>) {
        
    }
    
    func insert(_ element: Element) -> BTreeIterator<Element> {
        
        //if (empty()) {
        //  *mutable_root() = new_leaf_root_node(1);
        //}
        if isEmpty() {
            let node = BTreeNode<Element>.createLeaf(order: order, parent: nil)
            node.parent = node
            root = node
        }
        
        guard let root = root else {
            fatalError("BTree.insert(_ element: Element) root is null")
        }
        
        //iterator iter = internal_upper_bound(key, iterator(root(), 0));
        let rootIterator = BTreeIterator(node: root, index: 0)
        
        //TODO: upper bound...
        
        //if (!iter.node) {
        //    iter = end();
        //}
        
        //return internal_insert(iter, *value);
        return insert(iterator: rootIterator, element: element)
    }
    
    
    //need funcs:
    // tree::delete_leaf_node
    // tree::rebalance_or_split
    
    
    
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
        //iter.node->insert_value(iter.position, v);
        node.insert_value(index: iterator.index, element: element)
        
        //return iter;
        return iterator
    }
    
    //inline IterType btree<P>::internal_last(IterType iter) {
    func internal_last(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
     
        //while (iter.node && iter.position == iter.node->count()) {
        while var node = iterator.node, iterator.index == node.count {
            //iter.position = iter.node->position();
            iterator.index = node.index
            //iter.node = iter.node->parent();
            iterator.node = node.parent
            //if (iter.node->leaf()) {
            if node.isLeaf {
                //iter.node = NULL;
                iterator.node = nil
            }
        }
        //return iter;
        
        return iterator
    }
    
    func internal_upper_bound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        //if (iter.node) {
        //for (;;) {
        while var node = iterator.node {
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
        //iter = internal_last(iter);
        //return iter;
        return internal_last(iterator: iterator)
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
        
        node.leftmost = findLeftMost(node)
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
                    if node.isLeaf {
                        print("R|L {\(name)} \(values)")
                    } else {
                        print("R|I {\(name)} \(values)")
                    }
                } else {
                    let name = nameOfNode(node, level: level, nodes: nodes)
                    let parentName = nameOfNode(node.parent, level: level - 1, nodes: nodes)
                    
                    names[node] = name
                    
                    if node.isLeaf {
                        print("N|L {\(name)} \(values) in {\(parentName)}[\(node.index)]")
                    } else {
                        print("N|I {\(name)} \(values) in {\(parentName)}[\(node.index)]")
                    }
                }
            }
            print("___\n")
        }
        
        if let root = root {
            if let lm = root.leftmost {
                print("left most: \(names[lm] ?? "?")")
            }
            if let rm = root.rightmost {
                print("right most: \(names[rm] ?? "?")")
            }
        }
        
        print("___End: Printing Tree")
    }
    
}
