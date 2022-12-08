//
//  BTree.swift
//
//  Created by Nick Raptis on 11/25/22.
//

import Foundation

class BTree<Element: Comparable> {
    
    private let order: Int
    private let minOrder: Int
    
    private var root: BTreeNode<Element>? = nil
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
        remove(startIterator: begin, endIterator: endIterator)
    }
    
    func remove(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) {
        var iterator = BTreeIterator<Element>(iterator: startIterator)
        let count = distance(startIterator: startIterator, endIterator: endIterator)
        for _ in 0..<count {
            iterator = remove(iterator: iterator)
        }
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
    
    fileprivate class BTreeNode<Element: Comparable> {
        
        required init(order: Int, isLeaf: Bool) {
            self.order = order
            self.isLeaf = isLeaf
            parent = nil
            values = [Element]()
            values.reserveCapacity(order)
            if isLeaf {
                children = [BTreeNode<Element>]()
            } else {
                children = [BTreeNode<Element>]()
                children.reserveCapacity(order + 1)
            }
        }
        
        var order: Int
        var index: Int = 0
        var count: Int = 0
        var isLeaf: Bool
        var parent: BTreeNode<Element>?
        var values: [Element]
        var children: [BTreeNode<Element>]
        
        func insertValueLeaf(index: Int, element: Element) {
            values.insert(element, at: index)
            count += 1
        }
        
        func insertValueInternal(index: Int, element: Element, node: BTreeNode<Element>) {
            if !isLeaf {
                let index = index + 1
                children.insert(node, at: index)
                node.parent = self
                for seek in index..<children.count {
                    children[seek].index = seek
                }
            }
            values.insert(element, at: index)
            count += 1
        }
        
        func remove(index: Int) {
            if !isLeaf {
                children.remove(at: index + 1)
                for seek in (index + 1)..<children.count {
                    children[seek].index = seek
                }
            }
            count -= 1
            values.remove(at: index)
        }
        
        func lowerBound(element: Element) -> Int {
            var start = 0
            var end = count
            while start != end {
                let mid = (start + end) >> 1
                if element > values[mid] {
                    start = mid + 1
                } else {
                    end = mid
                }
            }
            return start
        }
        
        func upperBound(element: Element) -> Int {
            var start = 0
            var end = count
            while start != end {
                let mid = (start + end) >> 1
                if element >= values[mid] {
                    start = mid + 1
                } else {
                    end = mid
                }
            }
            return start
        }
        
        func swap(node: BTreeNode<Element>) {
            Swift.swap(&values, &node.values)
            if !isLeaf {
                Swift.swap(&children, &node.children)
                for child in children {
                    child.parent = self
                }
                for child in node.children {
                    child.parent = node
                }
            }
            Swift.swap(&count, &node.count)
        }
        
        func split(target: BTreeNode<Element>, insertIndex: Int) {
            guard let parent = parent else {
                return
            }
            var newTargetCount = 0
            if insertIndex == 0 {
                newTargetCount = (count - 1)
            } else if insertIndex != order {
                newTargetCount = (count >> 1)
            }
            var newCount = (count - newTargetCount)
            for seek in 0..<newTargetCount {
                target.values.append(values[newCount + seek])
            }
            newCount -= 1
            parent.insertValueInternal(index: index, element: values[newCount], node: target)
            values.removeLast(values.count - newCount)
            count = newCount
            target.count = newTargetCount
            
            if !isLeaf {
                let countPlus1 = count + 1
                for seek in 0...target.count {
                    let child = children[countPlus1 + seek]
                    child.parent = target
                    child.index = seek
                    target.children.append(child)
                }
                children.removeLast(target.count + 1)
            }
        }
        
        func merge(source: BTreeNode<Element>) {
            if !isLeaf {
                for seek in 0...source.count {
                    let child = source.children[seek]
                    child.index = count + seek + 1
                    child.parent = self
                    children.append(child)
                }
                source.children.removeAll(keepingCapacity: true)
            }
            if let parent = parent {
                values.append(parent.values[index])
                values.append(contentsOf: source.values)
                count = ((1 + count) + source.count)
                source.count = 0
                source.values.removeAll(keepingCapacity: true)
                source.children.removeAll(keepingCapacity: true)
                parent.remove(index: index)
            }
        }
        
        func rebalanceRightToLeft(target: BTreeNode<Element>, moveCount: Int) {
            if !isLeaf {
                for seek in 0..<moveCount {
                    let child = target.children[seek]
                    child.index = seek + count + 1
                    child.parent = self
                    children.append(child)
                }
                target.children.removeFirst(moveCount)
                for seek in 0..<target.children.count {
                    target.children[seek].index = seek
                }
            }
            
            if let parent = parent {
                values.append(parent.values[index])
                parent.values[index] = target.values[moveCount - 1]
            }
            let ceiling = (moveCount - 1)
            for seek in 0..<ceiling {
                values.append(target.values[seek])
            }
            target.values.removeFirst(moveCount)
            count += moveCount
            target.count -= moveCount
        }
        
        func rebalanceLeftToRight(target: BTreeNode<Element>, moveCount: Int) {
            if !isLeaf {
                var targetChildren = [BTreeNode<Element>]()
                for seek in 0..<moveCount {
                    let child = children[count - moveCount + seek + 1]
                    child.index = seek
                    child.parent = target
                    targetChildren.append(child)
                }
                for seek in 0...target.count {
                    let child = target.children[seek]
                    child.index = seek + moveCount
                    targetChildren.append(child)
                }
                target.children = targetChildren
                children.removeLast(moveCount)
            }
            
            var targetFrontValues = [Element]()
            targetFrontValues.reserveCapacity(order)
            for seek in (count - (moveCount) + 1)..<count {
                targetFrontValues.append(values[seek])
            }
            if let parent = parent {
                targetFrontValues.append(parent.values[index])
                parent.values[index] = values[count - moveCount]
            }
            target.values.insert(contentsOf: targetFrontValues, at: 0)
            values.removeLast(moveCount)
            
            count -= moveCount
            target.count += moveCount
        }
    }
    
    struct BTreeIterator<Element: Comparable>: Equatable {
        
        static func == (lhs: BTreeIterator<Element>, rhs: BTreeIterator<Element>) -> Bool {
            (lhs.node === rhs.node) && (lhs.index == rhs.index)
        }
        
        var tree: BTree<Element>
        fileprivate var node: BTreeNode<Element>?
        var index: Int
        
        fileprivate init(tree: BTree<Element>, node: BTreeNode<Element>?, index: Int) {
            self.tree = tree
            self.node = node
            self.index = index
        }
        
        init(iterator: BTreeIterator<Element>) {
            self.tree = iterator.tree
            self.node = iterator.node
            self.index = iterator.index
        }
        
        mutating func set(iterator: BTreeIterator<Element>) {
            self.tree = iterator.tree
            self.node = iterator.node
            self.index = iterator.index
        }
        
        func value() -> Element? {
            return value(index: index)
        }
        
        func value(index: Int) -> Element? {
            if let node = node {
                return node.values[index]
            }
            return nil
        }
        
        mutating func increment() {
            if var node = node {
                if node.isLeaf {
                    index += 1
                    if index < node.count {
                        return
                    }
                }
                
                if node.isLeaf {
                    let holdNode = node
                    let holdIndex = index
                    while (index >= node.count) && (node !== tree.root), let parent = node.parent {
                        index = node.index
                        node = parent
                    }
                    if index >= node.count {
                        node = holdNode
                        index = holdIndex
                    }
                } else {
                    let child = node.children[index + 1]
                    node = child
                    while !node.isLeaf {
                        node = node.children[0]
                    }
                    index = 0
                }
                self.node = node
            }
        }
        
        mutating func decrement() {
            if var node = node {
                if node.isLeaf {
                    index -= 1
                    if index >= 0 {
                        return
                    }
                }
                
                if node.isLeaf {
                    let holdNode = node
                    let holdIndex = index
                    
                    while (index < 0) && (node !== tree.root), let parent = node.parent {
                        index = node.index - 1
                        node = parent
                    }
                    if index < 0 {
                        node = holdNode
                        index = holdIndex
                    }
                } else {
                    let child = node.children[index]
                    node = child
                    while !node.isLeaf {
                        node = node.children[node.count]
                    }
                    index = node.count - 1
                }
                self.node = node
            }
        }
    }
    
    struct BTreeSequenceIterator<Element: Comparable>: IteratorProtocol {
        fileprivate let startIterator: BTreeIterator<Element>
        fileprivate let endIterator: BTreeIterator<Element>
        fileprivate var iterator: BTreeIterator<Element>
        fileprivate init(startIterator: BTreeIterator<Element>, endIterator: BTreeIterator<Element>) {
            self.startIterator = startIterator
            self.endIterator = endIterator
            self.iterator = startIterator
        }
        mutating func next() -> Element? {
            if iterator != endIterator {
                let result = iterator.value()
                iterator.increment()
                return result
            }
            return nil
        }
    }
}

extension BTree: Sequence {
    func makeIterator() -> BTree.BTreeSequenceIterator<Element> {
        let startIterator = startIterator()
        let endIterator = endIterator()
        return BTree.BTreeSequenceIterator(startIterator: startIterator, endIterator: endIterator)
    }
}
