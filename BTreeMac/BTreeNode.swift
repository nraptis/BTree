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
            self.children = [BTreeNode<Element>?]()
        } else {
            self.children = [BTreeNode<Element>?](repeating: nil, count: order + 1)
        }
    }
    
    var order: Int
    var index: Int = 0
    var count: Int = 0
    var isLeaf: Bool
    var parent: BTreeNode<Element>?
    var values: [Element]
    var children: [BTreeNode<Element>?]
    
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
            
            for childO in children {
                if let child = childO {
                    child.parent = self
                }
            }
            
            for childO in node.children {
                if let child = childO {
                    child.parent = node
                }
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
        
        let parentMockValue = (count > 0) ? values[0] : dest.values[0]
        
        var newTargetCount = 0
        if insertIndex == 0 {
            newTargetCount = (count - 1)
        } else if insertIndex == order {
            
        } else {
            newTargetCount = (count >> 1)
        }
        
        var newCount = (count - newTargetCount)
        
        var lewper = 0
        while lewper < newTargetCount {
            dest.values.append(parentMockValue)
            lewper += 1
        }

        var i = 0
        while i < newTargetCount {
            value_swap(i: newCount + i, x: dest, j: i)
            i += 1
        }
        
        newCount -= 1
        
        guard let parent = parent else {
            fatalError("BTreeNode.split() parent is null")
        }
        
        parent.insert_value(index: index, element: parentMockValue)
        
        value_swap(i: newCount, x: parent, j: index)
        
        while values.count > newCount {
            values.removeLast()
        }
        
        count = newCount
        dest.count = newTargetCount
        
        if !(count == values.count) {
            fatalError("count mismatch 1")
        }
        if !(dest.count == dest.values.count) {
            fatalError("count mismatch 2")
        }
        
        parent.set_child(i: index + 1, node: dest)
        
        if !isLeaf {
            
            i = 0
            while i <= dest.count {
            
                guard let child = child(index: count + i + 1) else {
                    fatalError("BTreeNode.split() child missing count (\(count)) + i (\(i)) + 1")
                }
                
                dest.set_child(i: i, node: child)
                children[count + i + 1] = nil
                
                i += 1
            }
        }
    }
    
    func insert_value(index: Int, element: Element) {
        values.insert(element, at: index)
        
        count += 1
        
        if !isLeaf {
            let index = index + 1
            var j = count
            while j > index {
                children[j] = children[j - 1]
                children[j]?.index = j
                
                j -= 1
            }
        }
    }
    
    func remove_value(index: Int) {
        if !isLeaf {
            guard var child = child(index: index + 1) else {
                fatalError("BTreeNode.remove_value(index: Int, element: Element) child index (\(index)) + 1 is null")
            }
            guard child.count == 0 else {
                fatalError("BTreeNode.remove_value(index: Int, element: Element) child index (\(index)) + 1, child.count (\(child.count)) expected 0")
            }
            
            var j = index + 1
            while j < count {
                if let child = children[j + 1] {
                    children[j] = child
                    child.index = j
                } else {
                    children[j] = nil
                }
                
                j += 1
            }
            
            children[count] = nil
        }
        
        count -= 1
        
        /*
        var index = index
        while index < count {
            values[index] = values[index + 1]
            index += 1
        }
        values[index] = nil
        */
        values.remove(at: index)
    }
    
    func merge(source: BTreeNode<Element>) {
        guard let parent = parent else {
            fatalError("BTreeNode.merge() parent is null")
        }
        
        let mockValue = parent.values[index]
        
        let ceil = (1 + count) + source.count
        while values.count < ceil {
            values.append(mockValue)
        }
        
        
        value_swap(i: count, x: parent, j: index)
        
        var i = 0
        while i < source.count {
            value_swap(i: 1 + count + i, x: source, j: i)
            i += 1
        }
        
        if !isLeaf {
            i = 0
            while i <= source.count {
                guard let sourceChild = source.child(index: i) else {
                    fatalError("BTreeNode.merge() source.child(index: i (\(i))) is null")
                }
                set_child(i: 1 + count + i, node: sourceChild)
                source.children[i] = nil
                i += 1
            }
        }
        
        count = ((1 + count) + source.count)
        source.count = 0
        parent.remove_value(index: index)
        
        source.children.removeAll(keepingCapacity: true)
        
    }
    
    func value_swap(i: Int, x: BTreeNode<Element>, j: Int) {
        let hold = values[i]
        values[i] = x.values[j]
        x.values[j] = hold
    }
    
    func destroy() {
        
    }
    
    func set_child(i: Int, node: BTreeNode<Element>) {
        children[i] = node
        node.parent = self
        node.index = i
    }
    
    func rebalance_right_to_left(src: BTreeNode<Element>, moveCount: Int) {
        
        guard let parent = parent else { return }
        
        
        var mockValue = parent.values[index]
        let ceil = count + moveCount
        while values.count < ceil {
            values.append(mockValue)
        }
        
        value_swap(i: count, x: parent, j: index)
        
        parent.value_swap(i: index, x: src, j: moveCount - 1)

        
        
        var i = 1
        while i < moveCount {
            
            value_swap(i: count + i, x: src, j: i - 1)
            i += 1
        }
        // Shift the values in the right node to their correct position.
        i = moveCount
        while i < src.count {
            src.value_swap(i: i - moveCount, x: src, j: i)
            i += 1
        }

        if !isLeaf {

            i = 0
            while i < moveCount {
                if let srcChild = src.child(index: i) {
                    set_child(i: 1 + count + i, node: srcChild)
                }
                i += 1
            }

            i = 0
            while i <= (src.count - moveCount) {
                guard i + moveCount <= src.order else {
                    fatalError("BTreeNode.rebalance_right_to_left i (\(i)) + moveCount (\(moveCount)) > src.order (\(src.order))")
                }
                guard let srcChild = src.child(index: i + moveCount) else {
                    fatalError("BTreeNode.rebalance_right_to_left missing child i (\(i)) + moveCount (\(moveCount))")
                }
                src.set_child(i: i, node: srcChild)
                src.children[i + moveCount] = nil
                i += 1
            }
        }
        
        count += moveCount
        src.count -= moveCount
        
        src.values.removeLast(moveCount)
    }
    
    func rebalance_left_to_right(dest: BTreeNode<Element>, moveCount: Int) {
        var i = dest.count - 1
        
        if let parent = parent {
            
            let mockValue = parent.values[index]
            let ceil = dest.count + moveCount
            while dest.values.count < ceil {
                dest.values.append(mockValue)
            }
            
            
        while i >= 0 {
            dest.value_swap(i: i, x: dest, j: i + moveCount)
            i -= 1
        }

        
            dest.value_swap(i: moveCount - 1, x: parent, j: index)
            parent.value_swap(i: index, x: self, j: count - moveCount)
        }
        
        i = 1
        while i < moveCount {
            value_swap(i: count - moveCount + i, x: dest, j: i - 1)
            
            i += 1
        }

        if !isLeaf {

            i = dest.count
            while i >= 0 {
                guard let destChild = dest.child(index: i) else {
                    fatalError("BTreeNode.rebalance_left_to_right missing child index: \(i)")
                }
                dest.set_child(i: i + moveCount, node: destChild)
                dest.children[i] = nil
                i -= 1
            }

            i = 1
            while i <= moveCount {
                
                guard let selfChild = child(index: count - moveCount + i) else {
                    fatalError("BTreeNode.rebalance_left_to_right missing child index: (count (\(i)) - moveCount (\(moveCount)) + i (\(i)))")
                }
                
                dest.set_child(i: i - 1, node: selfChild)
                children[count - moveCount + i] = nil
                
                i += 1
            }
        }
        
        count -= moveCount
        dest.count += moveCount
        
        values.removeLast(moveCount)
        
    }
    
}
