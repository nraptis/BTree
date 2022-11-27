//
//  MockSearchTree.swift
//  Tests
//
//  Created by Nick Raptis on 11/22/22.
//

import Foundation
@testable import TreeTests

class MockSearchTree<Element: Comparable>: BinarySearchTreeConforming {
    
    final class MockSearchTreeNode<Element>: BinaryTreeNodeConforming {
        var value: Element
        var left: MockSearchTreeNode<Element>?
        var right: MockSearchTreeNode<Element>?
        init(value: Element) {
            self.value = value
        }
    }
    
    var data = [Element]()
    
    var root: MockSearchTreeNode<Element>?
    
    var count: Int = 0
    
    func insert(_ element: BinaryTreeNode.Element) {
        if !contains(element) {
            data.append(element)
            data.sort()
            count += 1
        }
    }
    
    public func index(_ element: Element) -> Int? {
        var lo = 0
        var hi = data.count - 1
        while lo <= hi {
            let mid = (lo + hi) >> 1
            if (element < data[mid]) {
                hi = mid - 1
            } else if element > data[mid] {
                lo = mid + 1
            } else {
                return mid
            }
        }
        return nil
    }
    
    func contains(_ element: BinaryTreeNode.Element) -> Bool {
        return index(element) != nil
    }
    
    func clear() {
        data.removeAll()
        count = 0
    }
    
    func remove(_ element: BinaryTreeNode.Element) {
        for index in 0..<data.count {
            let value = data[index]
            if value == element {
                data.remove(at: index)
                count -= 1
                return
            }
        }
    }
    
    func popMin() -> BinaryTreeNode.Element? {
        let result = getMin()
        removeMin()
        return result
    }
    
    func getMin() -> BinaryTreeNode.Element? {
        if data.count > 0 {
            return data[0]
        }
        return nil
    }
    
    func removeMin() {
        if data.count > 0 {
            data.remove(at: 0)
            count -= 1
        }
    }
    
    func popMax() -> BinaryTreeNode.Element? {
        let result = getMax()
        removeMax()
        return result
    }
    
    func getMax() -> BinaryTreeNode.Element? {
        if data.count > 0 {
            return data[data.count - 1]
        }
        return nil
    }
    
    func removeMax() {
        if data.count > 0 {
            data.remove(at: data.count - 1)
            count -= 1
        }
    }
    
    func select(_ index: Int) -> Element? {
        if index < 0 { return nil }
        if index >= count { return nil }
        return data[index]
    }
    
    func printTree() {
        if count == nil {
            print("{nil mock tree}")
        } else {
            print("\(data)")
        }
    }
    
}
