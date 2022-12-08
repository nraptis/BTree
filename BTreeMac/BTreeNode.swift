//
//  BTree.swift
//
//  Created by Nick Raptis on 11/26/22.
//

import Foundation

class BTreeNode<Element: Comparable> {
    
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
    
    func split(target: BTreeNode<Element>, insertIndex: Int) {
        
        guard let parent = parent else { return }

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
    
    func insertValueLeaf(index: Int, element: Element) {
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
