//
//  BTree.swift
//
//  Created by Nick Raptis on 11/26/22.
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
    
    lazy var sentinel: BTreeNode<Element> = {
        BTreeNode(order: 0, isLeaf: true)
    }()
    
    func value(index: Int) -> Element? {
        guard index >= 0 && index < values.count else {
            fatalError("BTreeNode.value(index: Int) 2 index (\(index)) out of range [0..<\(values.count)]")
        }
        
        return values[index]
    }
    
    func child(index: Int) -> BTreeNode<Element>? {
        guard index >= 0 && index < children.count else {
            fatalError("BTreeNode.child(index: Int) index (\(index)) out of range [0..<\(children.count)]")
        }
        return children[index]
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
        
        guard isLeaf == node.isLeaf else {
            fatalError("BTreeNode.swap() isLeaf (\(isLeaf)) != node.isLeaf (\(node.isLeaf))")
        }
        
        let holdValues = values
        values = node.values
        node.values = holdValues
        
        if !isLeaf {
            let holdChildren = children
            children = node.children
            node.children = holdChildren
            
            for child in children {
                child.parent = self
            }
            
            for child in node.children {
                child.parent = node
            }
        }
        
        let holdCount = count
        count = node.count
        node.count = holdCount
    }
    
    func lowerBound(element: Element) -> Int {
        var start = 0
        var end = count
        while start != end {
            let mid = (start + end) >> 1
            
            guard let value = value(index: mid) else {
                fatalError("BTreeNode.lowerBound() value missing index: \(mid) count: \(count)")
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
        var end = count
        while start != end {
            let mid = (start + end) >> 1
            
            guard let value = value(index: mid) else {
                fatalError("BTreeNode.upperBound() value missing index: \(mid) count: \(count)")
            }
            
            if element >= value {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
    
    func split(dest: BTreeNode<Element>, insertIndex: Int) {
        
        guard let parent = parent else { return }

        var newTargetCount = 0
        if insertIndex == 0 {
            newTargetCount = (count - 1)
        } else if insertIndex == order {
            
        } else {
            newTargetCount = (count >> 1)
        }
        
        var newCount = (count - newTargetCount)
        
        
        for seek in 0..<newTargetCount {
            dest.values.append(values[newCount + seek])
        }
        
        newCount -= 1
        
        parent.insertValueInternal(index: index, element: values[newCount], node: dest)

        values.removeLast(values.count - newCount)
        count = newCount
        dest.count = newTargetCount
        
        
        if !isLeaf {
            
            for seek in 0...dest.count {
                
                let child = children[count + seek + 1]
                child.parent = dest
                child.index = seek
                dest.children.append(child)
            }
            
            children.removeLast(dest.count + 1)
            
            /*
            for (index, child) in dest.children.enumerated() {
                child.index = index
            }
            for (index, child) in children.enumerated() {
                child.index = index
            }
            */
        }
        
        /*
        if !isLeaf {
            
            var i = 0
            while i <= dest.count {
                
                dest.children.append(sentinel)
                i += 1
            }
            
            
            i = 0
            while i <= dest.count {
            
                guard let child = child(index: count + i + 1) else {
                    fatalError("BTreeNode.split() child missing count (\(count)) + i (\(i)) + 1")
                }
                
                dest.set_child(i: i, node: child)
                
                i += 1
            }
            
            i = 0
            while i <= dest.count {
                children.removeLast()
                i += 1
            }
            
            
            for (index, child) in dest.children.enumerated() {
                child.index = index
            }
            for (index, child) in children.enumerated() {
                child.index = index
            }
            
        }
        */
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
    
    func remove_value(index: Int) {
        
        //print("pre-remove_value, self")
        //printNode()
        
        if !isLeaf {
            
            //var j = index + 1
            
            children.remove(at: index + 1) // or index?
            
            for seek in (index + 1)..<children.count {
                children[seek].index = seek
            }
        }
        
        count -= 1
        
        values.remove(at: index)
        
        //print("post-remove_value, self")
        //printNode()
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
            parent.remove_value(index: index)
        }
    }
    
    func destroy() {
        values.removeAll(keepingCapacity: true)
        children.removeAll(keepingCapacity: true)
        //isLeaf = true
        parent = nil
        count = 0
    }
    
    func set_child(i: Int, node: BTreeNode<Element>) {
        if i == children.count {
            inject_child(i: i, node: node)
        } else if i < children.count {
            children[i] = node
            node.parent = self
            node.index = i
        } else {
            print("??? odd usage")
        }
    }
    
    func inject_child(i: Int, node: BTreeNode<Element>) {
        children.insert(node, at: i)
        node.parent = self
        node.index = i
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
    
    func printNode() {
        
        print("------------")
        print("name: \(name)")
        print("count: \(count)")
        print("values.count: \(values.count)")
        print("values: \(values)")
        print("children.count: \(children.count)")
        
        //var childNameArray = [String]()
        for (index, child) in children.enumerated() {
            print("child[\(index)] = \(child.name)")
        }
        print("PARENT:")
        printParent()
    }
    
    func printParent() {
        
        if let parent = parent {
            
            print("parent_name: \(parent.name)")
            print("parent_count: \(parent.count)")
            print("parent_values.count: \(parent.values.count)")
            print("parent_values: \(parent.values)")
            print("parent_children.count: \(parent.children.count)")
            //var childNameArray = [String]()
            for (index, child) in parent.children.enumerated() {
                print("parent_child[\(index)] = \(child.name)")
            }
        }
        print("------------")
    }
    
}
