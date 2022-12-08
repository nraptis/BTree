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
    
    private var rightMost: BTreeNode<Element>? = nil
    private var leftMost: BTreeNode<Element>? = nil
    
    required init(order: Int) {
        self.order = order
        self.minOrder = (order >> 1)
    }
    
    func isEmpty() -> Bool {
        return root === nil
    }
    
    func startIterator() -> BTreeIterator<Element> {
        BTreeIterator<Element>(tree: self, node: leftMost, index: 0)
    }
    
    func endIterator() -> BTreeIterator<Element> {
        if let node = rightMost {
            return BTreeIterator<Element>(tree: self, node: node, index: node.count)
        } else {
            return BTreeIterator<Element>(tree: self, node: nil, index: 0)
        }
    }
    
    func contains(_ element: Element) -> Bool {
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        let iterator = search(iterator: rootIterator, element: element)
        return iterator.node != nil
    }
    
    func countElement(_ element: Element) -> Int {
        let lowerBound = lowerBound(element: element)
        let upperBound = upperBound(element: element)
        return distance(startIterator: lowerBound, endIterator: upperBound)
    }
    
    func insert(_ element: Element) {
        if isEmpty() {
            let newRoot = BTreeNode<Element>(order: order, isLeaf: true)
            root = newRoot
            rightMost = root
            leftMost = root
        }
        
        guard let root = root else {
            return
        }
        
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        var iterator = upperBound(iterator: rootIterator, element: element)
        
        if iterator.node == nil {
            iterator = endIterator()
        }
        
        insert(iterator: iterator, element: element)
    }
    
    func remove(_ element: Element) {
        let begin = lowerBound(iterator: BTreeIterator(tree: self, node: root, index: 0), element: element)
        if begin.node == nil {
            return
        }
        let upperBoundIterator = upperBound(iterator: BTreeIterator(tree: self, node: root, index: 0), element: element)
        let endIterator = endIterator(iterator: upperBoundIterator)
        _ = remove(startIterator: begin, endIterator: endIterator)
    }
    
    func remove(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) -> Int {
        var iterator = BTreeIterator<Element>(iterator: startIterator)
        let count = distance(startIterator: startIterator, endIterator: endIterator)
        for _ in 0..<count {
            iterator = remove(iterator: iterator)
        }
        return count
    }
    
    func lowerBound(element: Element) -> BTreeIterator<Element> {
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        let lowerBoundIterator = lowerBound(iterator: rootIterator, element: element)
        let result = endIterator(iterator: lowerBoundIterator)
        return result
    }
    
    func upperBound(element: Element) -> BTreeIterator<Element> {
        let rootIterator = BTreeIterator(tree: self, node: root, index: 0)
        let upperBoundIterator = upperBound(iterator: rootIterator, element: element)
        let result = endIterator(iterator: upperBoundIterator)
        return result
    }
    
    private func merge(left: BTreeNode<Element>, right: BTreeNode<Element>) {
        left.merge(source: right)
        if right.isLeaf {
            if rightMost === right {
                rightMost = left
            }
        }
    }
    
    private func distance(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) -> Int {
        if startIterator == endIterator {
            return 0
        } else {
            var result = 0
            var iterator = startIterator
            while iterator != endIterator {
                iterator.increment()
                result += 1
            }
            return result
        }
    }

    private func search(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        var iterator = iterator
        if iterator.node != nil {
            iterator = lowerBound(iterator: iterator, element: element)
            
            if iterator.node != nil {
                iterator = lastIterator(iterator: iterator)
                if let node = iterator.node, node.values[iterator.index] == element {
                    return iterator
                }
            }
        }
        return BTreeIterator<Element>(tree: self, node: nil, index: 0)
    }
    
    private func endIterator(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        if iterator.node != nil {
            return iterator
        } else {
            return endIterator()
        }
    }
    
    private func lastIterator(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        var iterator = iterator
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
    
    private func lowerBound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        var iterator = iterator
        if iterator.node != nil {
            while let node = iterator.node {
                iterator.index = node.lowerBound(element: element)
                if node.isLeaf {
                    break
                }
                iterator.node = node.children[iterator.index]
            }
            iterator = lastIterator(iterator: iterator)
        }
        return iterator
    }
    
    private func upperBound(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        var iterator = iterator
        if iterator.node != nil {
            while let node = iterator.node {
                iterator.index = node.upperBound(element: element)
                if node.isLeaf {
                    break
                }
                iterator.node = node.children[iterator.index]
            }
            iterator = lastIterator(iterator: iterator)
        }
        return iterator
    }
    
    private func insert(iterator: BTreeIterator<Element>, element: Element) {
        var iterator = iterator
        if let node = iterator.node {
            if !node.isLeaf {
                iterator.decrement()
                iterator.index += 1
            }
        }
        
        if let node = iterator.node {
            if node.count == node.order {
                rebalanceOrSplit(iterator: &iterator)
                count += 1
            } else {
                count += 1
            }
        }
        
        if let node = iterator.node {
            node.insertValueLeaf(index: iterator.index, element: element)
        }
    }
    
    private func remove(iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        var internalDelete = false
        var iterator = iterator
        if let node = iterator.node {
            if !node.isLeaf {
                let tmp_iter = BTreeIterator(iterator: iterator)
                iterator.decrement()
                if let nodeAfterDecrement = iterator.node {
                    swap(&nodeAfterDecrement.values[iterator.index], &node.values[tmp_iter.index])
                    internalDelete = true
                    count -= 1
                }
            } else {
                count -= 1
            }
        }
        
        if let node = iterator.node {
            node.remove(index: iterator.index)
        }
        
        var result = BTreeIterator(iterator: iterator)
        while let node = iterator.node {
            if node === root {
                if let root = root, root.count <= 0 {
                    if root.isLeaf {
                        self.root = nil
                    } else {
                        let child = root.children[0]
                        if child.isLeaf {
                            self.root = child
                            self.leftMost = child
                        } else {
                            child.swap(node: root)
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
            
            let merged = mergeOrRebalanceIfNecessary(iterator: &iterator)
            if node.isLeaf {
                result.set(iterator: iterator)
            }
            if !merged {
                break
            }
            iterator.node = iterator.node?.parent
        }
        
        if let node = result.node {
            if result.index == node.count {
                result.index = (node.count - 1)
                result.increment()
            }
        }
        if internalDelete {
            result.increment()
        }
        return result
    }
    
    private func mergeOrRebalanceIfNecessary(iterator: inout BTreeIterator<Element>) -> Bool {
        guard let parent = iterator.node?.parent else {
            return false
        }
        if let node = iterator.node {
            if node.index > 0 {
                let left = parent.children[node.index - 1]
                if (1 + left.count + node.count) <= left.order {
                    iterator.index += (1 + left.count)
                    merge(left: left, right: node)
                    iterator.node = left
                    return true
                }
            }
        }
        
        if let node = iterator.node {
            if node.index < parent.count {
                let right = parent.children[node.index + 1]
                if (1 + node.count + right.count) <= right.order {
                    merge(left: node, right: right)
                    return true
                }
                if (right.count > minOrder) && ((node.count == 0) || (node.index > 0)) {
                    var moveCount = (right.count - node.count) >> 1
                    if moveCount > (right.count - 1) {
                        moveCount = (right.count - 1)
                    }
                    node.rebalanceRightToLeft(target: right, moveCount: moveCount)
                    return false
                }
            }
        }
        if let node = iterator.node {
            if node.index > 0 {
                let left = parent.children[node.index - 1]
                if (left.count > minOrder) && ((node.count == 0) || (iterator.index < node.count)) {
                    var moveCount = (left.count - node.count) >> 1
                    if moveCount > (left.count - 1) {
                        moveCount = (left.count - 1)
                    }
                    left.rebalanceLeftToRight(target: node, moveCount: moveCount)
                    iterator.index += moveCount
                    return false
                }
            }
        }
        return false
    }
    
    private func rebalanceOrSplit(iterator: inout BTreeIterator<Element>) {
        guard var node = iterator.node else {
            return
        }
        
        if var target = node.parent ?? leftMost {
            var insertIndex = iterator.index
            if node !== root {
                if node.index > 0 {
                    let left = target.children[node.index - 1]
                    if left.count < left.order {
                        var denom = 1
                        if insertIndex < left.order {
                            denom += 1
                        }
                        var moveCount = (left.order - left.count) / denom
                        if moveCount < 1 {
                            moveCount = 1
                        }
                        if ((insertIndex - moveCount) >= 0) || ((left.count + moveCount) < left.order) {
                            left.rebalanceRightToLeft(target: node, moveCount: moveCount)
                            insertIndex -= moveCount
                            if insertIndex < 0 {
                                insertIndex = insertIndex + left.count + 1
                                node = left
                            }
                            iterator.node = node
                            iterator.index = insertIndex
                            return
                        }
                    }
                }
                
                if node.index < target.count {
                    let right = target.children[node.index + 1]
                    if right.count < right.order {
                        var denom = 1
                        if insertIndex > 0 {
                            denom += 1
                        }
                        var moveCount = (right.order - right.count) / (denom)
                        if moveCount < 1 {
                            moveCount = 1
                        }
                        if (insertIndex <= (node.count - moveCount)) || ((right.count + moveCount) < right.order) {
                            node.rebalanceLeftToRight(target: right, moveCount: moveCount)
                            if insertIndex > node.count {
                                insertIndex = insertIndex - node.count - 1
                                node = right
                            }
                            iterator.node = node
                            iterator.index = insertIndex
                            return
                        }
                    }
                }
                if target.count == target.order {
                    var parentIterator = BTreeIterator<Element>(tree: self, node: node.parent, index: node.index)
                    rebalanceOrSplit(iterator: &parentIterator)
                }
            } else {
                if let root = root {
                    if root.isLeaf {
                        let holdTarget = target
                        target = BTreeNode<Element>(order: order, isLeaf: false)
                        target.parent = holdTarget
                        target.children.append(root)
                        root.parent = target
                        target.index = 0
                        self.root = target
                    } else {
                        let holdTarget = target
                        target = BTreeNode<Element>(order: order, isLeaf: false)
                        target.parent = holdTarget
                        target.children.append(target)
                        target.index = 0
                        target.swap(node: root)
                        node = target
                    }
                }
            }
            
            if node.isLeaf {
                let target = BTreeNode<Element>(order: order, isLeaf: true)
                target.parent = target
                node.split(target: target, insertIndex: insertIndex)
                if rightMost === node {
                    rightMost = target
                }
                if insertIndex > node.count {
                    insertIndex = insertIndex - node.count - 1
                    node = target
                }
            } else {
                let holdTarget = target
                let target = BTreeNode<Element>(order: order, isLeaf: false)
                target.parent = holdTarget
                node.split(target: target, insertIndex: insertIndex)
                if insertIndex > node.count {
                    insertIndex = insertIndex - node.count - 1
                    node = target
                }
            }
            iterator.node = node
            iterator.index = insertIndex
        }
    }
}
