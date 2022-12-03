//
//  BTree.swift
//
//  Created by Nick Raptis on 11/25/22.
//

import Foundation

class BTree<Element: Comparable> {
    
    private let order: Int
    private let minOrder: Int
    
    private(set) var root: BTreeNode<Element>? = nil
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
    
    func startIterator() -> BTreeIterator<Element> {
        BTreeIterator<Element>(tree: self, node: root?.parent, index: 0)
    }
    
    func endIterator() -> BTreeIterator<Element> {
        if let node = root?.rightmost {
            return BTreeIterator<Element>(tree: self, node: node, index: node.count)
        } else {
            return BTreeIterator<Element>(tree: self, node: nil, index: 0)
        }
    }
    
    func delete_leaf_node(node: BTreeNode<Element>) {
        node.destroy()
    }
    
    //void btree<P>::rebalance_or_split(iterator *iter) {
    func rebalance_or_split(iterator: BTreeIterator<Element>) {
        
        //node_type *&node = iter->node;
        guard var node = iterator.node else {
            fatalError("BTree.rebalance_or_split() iterator.node is null")
        }
        
        
        
        guard var parent = node.parent else {
            fatalError("BTree.rebalance_or_split() node.parent is null")
        }
        
        var insert_position = iterator.index
        
        if node != root {
            
            if node.index > 0 {

                if let left = parent.child(index: node.index - 1) {
                    if left.count < left.order {
                        
                        var denom = 1
                        if insert_position < left.order {
                            denom += 1
                        }
                        var to_move = (left.order - left.count) / denom
                        
                        //to_move = std::max(1, to_move);
                        if to_move < 1 {
                            to_move = 1
                        }
                        
                        if ((insert_position - to_move) >= 0) || ((left.count + to_move) < left.order) {
                            
                            left.rebalance_right_to_left(src: node, to_move: to_move)
                            
                            insert_position -= to_move
                            
                            if insert_position < 0 {
                                
                                insert_position = insert_position + left.count + 1
                                
                                node = left
                                
                            }
                            
                            iterator.node = node
                            
                            iterator.index = insert_position
                            
                            return
                        }
                    }
                }
            }
            
            if node.index < parent.count {
                if let right = parent.child(index: node.index + 1)  {
                    if right.count < right.order {
                        var denom = 1
                        if insert_position > 0 {
                            denom += 1
                        }
                        var to_move = (right.order - right.count) / (denom)
                        
                        if to_move < 1 {
                            to_move = 1
                        }
                        
                        if (insert_position <= (node.count - to_move)) || ((right.count + to_move) < right.order) {
                            
                            node.rebalance_left_to_right(dest: right, to_move: to_move)
                            
                            if insert_position > node.count {
                                
                                insert_position = insert_position - node.count - 1
                                
                                node = right
                                
                            }
                            
                            iterator.node = node
                            iterator.index = insert_position
                            
                            return
                        }
                    }
                }
            }

            if parent.count == parent.order {
                //iterator parent_iter(node->parent(), node->position());
                let parentIterator = BTreeIterator<Element>(tree: self, node: node.parent, index: node.index)
                
                //rebalance_or_split(&parent_iter);
                rebalance_or_split(iterator: parentIterator)
            }
            
        } else {
            
            guard let root = root else {
                fatalError("BTree.rebalance_or_split() root is null")
            }
            
            if root.isLeaf {

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

                parent = BTreeNode<Element>.createInternal(order: order, parent: parent)
                parent.set_child(i: 0, node: parent)
                
                //parent->swap(root());
                parent.swap(node: root)
                
                //node = parent;
                node = parent
            }
            
        }

        if node.isLeaf {
            
            guard let root = root else {
                fatalError("BTree.rebalance_or_split() root is null")
            }
        
            let split_node = new_leaf_node(parent: parent)
            
            node.split(dest: split_node, insert_position: insert_position)
            
            if root.rightmost === node {
                
                root.rightmost = split_node
            }
            
            if insert_position > node.count {
                insert_position = insert_position - node.count - 1
                node = split_node
            }
        } else {
            
            let split_node = BTreeNode<Element>.createInternal(order: order, parent: parent)
            
            node.split(dest: split_node, insert_position: insert_position)
            
            if insert_position > node.count {
                insert_position = insert_position - node.count - 1
                node = split_node
            }
        }

        iterator.node = node
        iterator.index = insert_position
        
    }
    
    //iterator internal_end(iterator iter) {
    private func internal_end(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        //return iter.node ? iter : end();
        if iterator.node != nil {
            return iterator
        } else {
            return endIterator()
        }
    }
    
    
    func contains(_ element: Element) -> Bool {
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        let iterator = internal_find_multi(iterator: rootIterator, element: element)
        return iterator.node != nil
    }
    
    func countElement(_ element: Element) -> Int {
        let lowerBound = lowerBound(element: element)
        let upperBound = upperBound(element: element)
        return distance(startIterator: lowerBound, endIterator: upperBound)
    }
    
    func insert(_ element: Element) {
        
        if isEmpty() {
            self.root = new_leaf_root_node()
        }
        
        guard let root = root else {
            fatalError("BTree.insert(_ element: Element) root is null")
        }
        
        //iterator iter = internal_upper_bound(key, iterator(root(), 0));
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        var iterator = upperBound(iterator: rootIterator, element: element)
        
        //TODO: upper bound...

        if iterator.node == nil {
            iterator = endIterator()
        }
        
        //return internal_insert(iter, *value);
        //return
        insert(iterator: iterator, element: element)
    }
    
    
    @discardableResult
    private func insert(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        
        if let node = iterator.node {
            if !node.isLeaf {
                iterator.decrement()
                iterator.index += 1
            }
        }
        
        if let node = iterator.node {
            if node.count == node.order {
                rebalance_or_split(iterator: iterator)
                count += 1
            } else {
                count += 1
            }
        }
        
        if let node = iterator.node {
            node.insert_value(index: iterator.index, element: element)
        }
        return iterator
    }
    
    func remove(_ element: Element) {
        let begin = lowerBound(iterator: BTreeIterator(tree: self, node: root, index: 0), element: element)
        if begin.node == nil {
            return
        }
        let upperBnd = upperBound(iterator: BTreeIterator(tree: self, node: root, index: 0), element: element)
        let end = internal_end(iterator: upperBnd)
        //print("Delete from \(begin.node!.name) (\(begin.index)) to \(end.node!.name) (\(end.index))")
        _ = remove(startIterator: begin, endIterator: end)
    }
    
    func remove(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        
        var internal_delete = false
        
        if let node = iterator.node {
            if !node.isLeaf {
                let tmp_iter = BTreeIterator(iterator: iterator)
                iterator.decrement()
                if let nodeAfterDecrement = iterator.node {
                    nodeAfterDecrement.value_swap(i: iterator.index, x: node, j: tmp_iter.index)
                    internal_delete = true
                    count -= 1
                }
            } else {
                count -= 1
            }
        }
        
        if let node = iterator.node {
            node.remove_value(index: iterator.index)
        }
        
        var result = BTreeIterator(iterator: iterator)
        while var node = iterator.node {
            if node === root {
                if let root = root, root.count <= 0 {
                    if root.isLeaf {
                        delete_leaf_node(node: root)
                        self.root = nil
                    } else {
                        if let child = root.child(index: 0) {
                            if child.isLeaf {
                                child.make_root()
                                delete_internal_root_node()
                                self.root = child
                                
                            } else {
                                child.swap(node: root)
                                delete_internal_node(child)
                            }
                        }
                    }
                }
                if root == nil {
                    return endIterator()
                }
                break
            }
            if node.count >= minOrder {
                break
            }
            
            let merged = try_merge_or_rebalance(iterator: iterator)
            if node.isLeaf {
                result.set(iterator: iterator)
            }
            if !merged {
                break
            }
            
            iterator.node = iterator.node?.parent
        }
        
        guard let node = result.node else {
            fatalError("BTree.remove(iterator: BTreeIterator<Element>) result.node is null")
        }
        
        if result.index == node.count {
            result.index = (node.count - 1)
            result.increment()
        }
        
        if internal_delete {
            result.increment()
        }
        return result
    }
    
    func remove(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) -> Int {
        var iterator = BTreeIterator<Element>(iterator: startIterator)
        let count = distance(startIterator: startIterator, endIterator: endIterator)
        for _ in 0..<count {
            iterator = remove(iterator: iterator)
        }
        return count
    }
    
    func merge_nodes(left: BTreeNode<Element>, right: BTreeNode<Element>) {
        left.merge(source: right)
        if right.isLeaf {
            if let root = root, root.rightmost == right {
                root.rightmost = left
            }
            delete_leaf_node(node: right)
        } else {
            delete_internal_node(right)
        }
    }
    
    func try_merge_or_rebalance(iterator: BTreeIterator<Element>) -> Bool {

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
        
        if let node = iterator.node {
            if node.index < parent.count {
                guard let right = parent.child(index: node.index + 1) else {
                    fatalError("BTree.try_merge_or_rebalance() parent.child(index: node.index (\(node.index)) + 1) is nil")
                }
                if (1 + node.count + right.count) <= right.order {
                    merge_nodes(left: node, right: right)
                    return true
                }
                
                if (right.count > minOrder) && ((node.count == 0) || (node.index > 0)) {
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

                if let left = parent.child(index: node.index - 1) {
                    
                    if (left.count > minOrder) && ((node.count == 0) || (iterator.index < node.count)) {
                        
                        var to_mode = (left.count - node.count) >> 1
                        
                        
                        if to_mode > (left.count - 1) {
                            to_mode = (left.count - 1)
                        }
                        
                        left.rebalance_left_to_right(dest: node, to_move: to_mode)
                        
                        iterator.index += to_mode
                        
                        return false
                    }
                }
            }
        }
        
        return false
    }
    
    func delete_leaf_node(_ node: BTreeNode<Element>) {
        node.destroy()
    }
    
    func delete_internal_node(_ node: BTreeNode<Element>) {
        node.destroy()
    }
    
    func delete_internal_root_node() {
        if let root = root {
            root.destroy()
            root.isRoot = false
        }
    }
    
    func lastIterator(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        let iterator = BTreeIterator<Element>(iterator: iterator)
        while let node = iterator.node, iterator.index == node.count {
            iterator.index = node.index
            iterator.node = node.parent
            if let node = iterator.node {
                if node.isLeaf {
                    iterator.node = nil
                }
            }
        }
        return iterator
    }
    
    func lowerBound(element: Element) -> BTreeIterator<Element> {
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        
        let lowerBound = lowerBound(iterator: rootIterator, element: element)
        let result = internal_end(iterator: lowerBound)
        return result
    }
    
    func upperBound(element: Element) -> BTreeIterator<Element> {
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        let upperBound = upperBound(iterator: rootIterator, element: element)
        let result = internal_end(iterator: upperBound)
        return result
    }
    
    private func distance(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) -> Int {
        if startIterator == endIterator {
            return 0
        } else {
            var result = 0
            let iterator = BTreeIterator<Element>(iterator: startIterator)
            while iterator != endIterator {
                iterator.increment()
                result += 1
            }
            return result
        }
    }

    func internal_find_multi(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        var iterator = BTreeIterator<Element>(iterator: iterator)
        if iterator.node != nil {
            iterator = lowerBound(iterator: iterator, element: element)
            
            if iterator.node != nil {
                iterator = lastIterator(iterator: iterator)
                if let node = iterator.node, node.value(index: iterator.index) == element {
                    return iterator
                }
            }
        }
        return BTreeIterator<Element>(tree: self, node: nil, index: 0)
    }
    
    private func lowerBound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        var iterator = BTreeIterator<Element>(iterator: iterator)
        if iterator.node != nil {
            while let node = iterator.node {
                iterator.index = node.lowerBound(element: element)
                if node.isLeaf {
                    break
                }
                iterator.node = node.child(index: iterator.index)
            }
            iterator = lastIterator(iterator: iterator)
        }
        return iterator
    }
    
    private func upperBound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        var iterator = BTreeIterator<Element>(iterator: iterator)
        if iterator.node != nil {
            while let node = iterator.node {
                iterator.index = node.upperBound(element: element)
                
                if node.isLeaf {
                    break
                }
                iterator.node = node.child(index: iterator.index)
            }
            iterator = lastIterator(iterator: iterator)
        }
        return iterator
    }
    
    func new_internal_node(parent: BTreeNode<Element>) -> BTreeNode<Element> {
        let result = BTreeNode<Element>.createInternal(order: order, parent: parent)
        return result
    }
    
    func new_internal_root_node() -> BTreeNode<Element> {
        guard let parent = root?.parent else {
            fatalError("BTree.new_internal_root_node root?.parent is null")
        }
        let result = BTreeNode<Element>.createRootInternal(order: order, parent: parent)
        return result
    }
    
    func new_leaf_node(parent: BTreeNode<Element>) -> BTreeNode<Element> {
        let result = BTreeNode<Element>.createLeaf(order: order, parent: parent)
        return result
    }
    
    func new_leaf_root_node() -> BTreeNode<Element> {
        let result = BTreeNode<Element>.createRootLeaf(order: order)
        return result
    }
    
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
