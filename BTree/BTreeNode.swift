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
    
    required init(data: BTreeNodeData<Element>) {
        self.data = data
    }
    
    static func createLeaf(order: Int) -> BTreeNode<Element> {
        BTreeNode(data: BTreeNodeData.createLeaf(order: order))
    }
    
    static func createInternal(order: Int) -> BTreeNode<Element> {
        BTreeNode(data: BTreeNodeData.createInternal(order: order))
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
        guard index >= 0 && index < data.values.count else {
            fatalError("BTreeNode.value(index: Int) 2 index (\(index)) out of range [0..<\(data.values.count)]")
        }
        
        return data.values[index]
    }
    
    func child(index: Int) -> BTreeNode<Element>? {
        guard index >= 0 && index < data.children.count else {
            fatalError("BTreeNode.child(index: Int) index (\(index)) out of range [0..<\(data.children.count)]")
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
        
        guard isLeaf == node.isLeaf else {
            fatalError("BTreeNode.swap() isLeaf (\(isLeaf)) != node.isLeaf (\(node.isLeaf))")
        }

        let n = max(count, node.count)

        var i = 0
        while i < n {
            value_swap(i: i, x: node, j: i)
            i += 1
        }

        i = count
        while i < node.count {
            node.value_destroy(i: i)
            i += 1
        }

        i = node.count
        while i < count {
            value_destroy(i: i)
            i += 1
        }
        
        if !isLeaf {
            i = 0
            while i <= n {
                let hold = data.children[i]
                data.children[i] = node.data.children[i]
                node.data.children[i] = hold
                i += 1
            }

            i = 0
            while i <= count {
                node.data.children[i]?.parent = node
                i += 1
            }
            
            i = 0
            while i <= node.count {
                data.children[i]?.parent = self
                i += 1
            }
        }
        
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
    
    func split(dest: BTreeNode<Element>, insertIndex: Int) {
        
        if insertIndex == 0 {
            dest.count = count - 1
        } else if insertIndex == order {
            
        } else {
            dest.count = count >> 1
        }
        
        count = count - dest.count
        
        guard count >= 1 else {
            fatalError("BTreeNode.split() count (\(count)) < 1")
        }
        
        var i = 0
        while i < dest.count {
            value_swap(i: count + i, x: dest, j: i)
            
            value_destroy(i: count + i)
            
            i += 1
        }
        
        count = count - 1
        
        guard let parent = parent else {
            fatalError("BTreeNode.split() parent is null")
        }
        parent.insert_value(index: index, element: nil)
        
        value_swap(i: count, x: parent, j: index)
        value_destroy(i: count)
        
        parent.set_child(i: index + 1, node: dest)
        
        if !isLeaf {
            
            i = 0
            while i <= dest.count {
            
                guard let child = child(index: count + i + 1) else {
                    fatalError("BTreeNode.split() child missing count (\(count)) + i (\(i)) + 1")
                }
                
                dest.set_child(i: i, node: child)
                data.children[count + i + 1] = nil
                
                i += 1
            }
        }
    }
    
    func insert_value(index: Int, element: Element?) {
        
        var j = count
        while j > index {
            data.values[j] = data.values[j - 1]
            j -= 1
        }
        
        data.values[index] = element
        
        count += 1
        
        if !isLeaf {
            let index = index + 1
            j = count
            while j > index {
                data.children[j] = data.children[j - 1]
                data.children[j]?.index = j
                
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
                if let child = data.children[j + 1] {
                    data.children[j] = child
                    child.index = j
                } else {
                    data.children[j] = nil
                }
                
                j += 1
            }
            
            data.children[count] = nil
        }
        
        count -= 1
        var index = index
        while index < count {
            data.values[index] = data.values[index + 1]
            index += 1
        }
        data.values[index] = nil
    }
    
    func merge(source: BTreeNode<Element>) {
        guard let parent = parent else {
            fatalError("BTreeNode.merge() parent is null")
        }
        
        value_swap(i: count, x: parent, j: index)
        
        var i = 0
        while i < source.count {
            value_swap(i: 1 + count + i, x: source, j: i)
            source.value_destroy(i: i)
            i += 1
        }
        
        if !isLeaf {
            i = 0
            while i <= source.count {
                guard let sourceChild = source.child(index: i) else {
                    fatalError("BTreeNode.merge() source.child(index: i (\(i))) is null")
                }
                set_child(i: 1 + count + i, node: sourceChild)
                source.data.children[i] = nil
                i += 1
            }
        }
        
        count = ((1 + count) + source.count)
        source.count = 0
        parent.remove_value(index: index)
    }
    
    func value_swap(i: Int, x: BTreeNode<Element>, j: Int) {
        var hold = data.values[i]
        data.values[i] = x.data.values[j]
        x.data.values[j] = hold
    }
    
    func value_destroy(i: Int) {
        data.values[i] = nil
    }
    
    func destroy() {
        for index in 0..<count {
            value_destroy(i: index)
        }
    }
    
    func set_child(i: Int, node: BTreeNode<Element>) {
        data.children[i] = node
        node.parent = self
        node.index = i
    }
    
    func rebalance_right_to_left(src: BTreeNode<Element>, moveCount: Int) {
        
        
        if let parent = parent {
            
            //value_swap(count(), parent(), position());
            //TODO: This will crash, undoubtedly...
            //value_swap(i: count, x: parent, j: index)
            
            value_swap(i: count, x: parent, j: index)
            
            //parent()->value_swap(position(), src, moveCount - 1);
            parent.value_swap(i: index, x: src, j: moveCount - 1)
            
        } else {
            fatalError("BTreeNode.rebalance_right_to_left moveCount parent is nil")
        }
        
        // Move the values from the right to the left node.
        //for (int i = 1; i < moveCount; ++i) {
        var i = 1
        while i < moveCount {
            //value_swap(count() + i, src, i - 1);
            value_swap(i: count + i, x: src, j: i - 1)
            i += 1
        }
        // Shift the values in the right node to their correct position.
        //for (int i = moveCount; i < src->count(); ++i) {
        i = moveCount
        while i < src.count {
            //src->value_swap(i - moveCount, src, i);
            src.value_swap(i: i - moveCount, x: src, j: i)
            i += 1
        }
        
        //for (int i = 1; i <= moveCount; ++i) {
        i = 1
        while i <= moveCount {
            //src->value_destroy(src->count() - i);
            src.value_destroy(i: src.count - i)
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
                src.data.children[i + moveCount] = nil
                i += 1
            }
        }
        
        count += moveCount
        src.count -= moveCount
    }
    
    func rebalance_left_to_right(dest: BTreeNode<Element>, moveCount: Int) {
        var i = dest.count - 1
        while i >= 0 {
            dest.value_swap(i: i, x: dest, j: i + moveCount)
            i -= 1
        }

        if let parent = parent {
            dest.value_swap(i: moveCount - 1, x: parent, j: index)
            parent.value_swap(i: index, x: self, j: count - moveCount)
        }
        
        value_destroy(i: count - moveCount)

        i = 1
        while i < moveCount {
            value_swap(i: count - moveCount + i, x: dest, j: i - 1)
            value_destroy(i: count - moveCount + i)
            
            i += 1
        }

        if !isLeaf {

            i = dest.count
            while i >= 0 {
                guard let destChild = dest.child(index: i) else {
                    fatalError("BTreeNode.rebalance_left_to_right missing child index: \(i)")
                }
                dest.set_child(i: i + moveCount, node: destChild)
                dest.data.children[i] = nil
                i -= 1
            }

            i = 1
            while i <= moveCount {
                
                guard let selfChild = child(index: count - moveCount + i) else {
                    fatalError("BTreeNode.rebalance_left_to_right missing child index: (count (\(i)) - moveCount (\(moveCount)) + i (\(i)))")
                }
                
                dest.set_child(i: i - 1, node: selfChild)
                data.children[count - moveCount + i] = nil
                
                i += 1
            }
        }
        
        count -= moveCount
        dest.count += moveCount
    }
    
}
