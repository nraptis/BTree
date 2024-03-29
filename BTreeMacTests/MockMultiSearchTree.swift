//
//  MockSearchTree.swift
//  Tests
//
//  Created by Nick Raptis on 11/22/22.
//

import Foundation

class MockMultiSearchTree<Element: Comparable> {
    
    var data = [Element]()
    
    var count: Int = 0
    
    func insert(_ element: Element) {
        data.append(element)
        data.sort()
        count += 1
    }
    
    func contains(_ element: Element) -> Bool {
        var lo = 0
        var hi = count - 1
        while lo <= hi {
            let mid = (lo + hi) >> 1
            if (element < data[mid]) {
                hi = mid - 1
            } else if element > data[mid] {
                lo = mid + 1
            } else {
                return true
            }
        }
        return false
    }
    
    func countElement(_ element: Element) -> Int {
        let lb = lowerBound(element: element)
        let ub = upperBound(element: element)
        return (ub - lb)
    }
    
    func lowerBound(element: Element) -> Int {
        var start = 0
        var end = count
        while start != end {
            let mid = (start + end) >> 1
            if element > data[mid] {
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
            if element >= data[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
    
    func clear() {
        data.removeAll()
        count = 0
    }
    
    func remove(_ element: Element) {
        removeAll(element: element)
    }
    
    func removeFirst(element: Element) {
        for index in 0..<count {
            let value = data[index]
            if value == element {
                data.remove(at: index)
                count -= 1
                return
            }
        }
    }
    
    func removeAll(element: Element) {
        data.removeAll {
            $0 == element
        }
        count = data.count
    }
    
    func popMin() -> Element? {
        let result = getMin()
        removeMin()
        return result
    }
    
    func getMin() -> Element? {
        if count > 0 {
            return data[0]
        }
        return nil
    }
    
    func removeMin() {
        if count > 0 {
            data.remove(at: 0)
            count -= 1
        }
    }
    
    func popMax() -> Element? {
        let result = getMax()
        removeMax()
        return result
    }
    
    func getMax() -> Element? {
        if count > 0 {
            return data[count - 1]
        }
        return nil
    }
    
    func removeMax() {
        if count > 0 {
            data.remove(at: count - 1)
            count -= 1
        }
    }
}
