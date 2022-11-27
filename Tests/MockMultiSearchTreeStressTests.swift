//
//  MockMultiSearchTreeStressTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/27/22.
//

import XCTest
@testable import TreeTests

final class MockMultiSearchTreeStressTests: XCTestCase {

    func compare<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: [Element: Int]) -> Bool {
        for (key, value) in dict {
            if value != tree.countElement(key) {
                XCTFail("I - Comparing Dict: \(dict)")
                XCTFail("I - Comparing Tree: \(tree.data)")
                XCTFail("I - Failed on key: \(key), value (count): \(value)")
                return false
            }
        }
        
        for value in tree.data {
            if tree.countElement(value) != dict[value] {
                XCTFail("II - Comparing Dict: \(dict)")
                XCTFail("II - Comparing Tree: \(tree.data)")
                XCTFail("II - Failed on value: \(value)")
                return false
            }
        }
        
        return true
    }
    
    func addToBoth<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: inout [Element: Int], data: [Element]) {
        for i in 0..<data.count {
            tree.insert(data[i])
            if let count = dict[data[i]] {
                dict[data[i]] = count + 1
            } else {
                dict[data[i]] = 1
            }
        }
    }
    
    func removeOneFromBoth<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: inout [Element: Int], data: [Element]) {
        for i in 0..<data.count {
            tree.removeFirst(element: data[i])
            if let count = dict[data[i]] {
                if count == 1 {
                    dict.removeValue(forKey: data[i])
                } else {
                    dict[data[i]] = count - 1
                }
            }
        }
    }
    
    func removeAllFromBoth<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: inout [Element: Int], data: [Element]) {
        for i in 0..<data.count {
            tree.removeAll(element: data[i])
            dict.removeValue(forKey: data[i])
        }
    }
    
    func addToBoth<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: inout [Element: Int], element: Element) {
        tree.insert(element)
        if let count = dict[element] {
            dict[element] = count + 1
        } else {
            dict[element] = 1
        }
    }
    
    func removeOneFromBoth<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: inout [Element: Int], element: Element) {
        tree.removeFirst(element: element)
        if let count = dict[element] {
            if count == 1 {
                dict.removeValue(forKey: element)
            } else {
                dict[element] = count - 1
            }
        }
    }
    
    func removeAllFromBoth<Element: Hashable>(tree: MockMultiSearchTree<Element>, dict: inout [Element: Int], element: Element) {
        tree.removeAll(element: element)
        dict.removeValue(forKey: element)
    }
    
    func miniArray() -> [Int] {
        let count = Int.random(in: 0...5)
        var result = [Int](repeating: 0, count: count)
        for index in 0..<count {
            result[index] = Int.random(in: 0...10)
        }
        return result
    }
    
    func testMiniStressAdd() {
        for _ in 0..<10000 {
            let array = miniArray()
            var dict = [Int: Int]()
            let tree = MockMultiSearchTree<Int>()
            addToBoth(tree: tree, dict: &dict, data: array)
            if !compare(tree: tree, dict: dict) {
                XCTFail("MockMultiSearchTreeStressTests.miniStressTestAdd \(array) failed")
                return
            }
        }
    }
    
    func testMiniStressAddAndRemoveOne() {
        for _ in 0..<10000 {
            let arrayAdd = miniArray()
            let arrayRemove = miniArray()
            
            var dict = [Int: Int]()
            let tree = MockMultiSearchTree<Int>()
            addToBoth(tree: tree, dict: &dict, data: arrayAdd)
            if !compare(tree: tree, dict: dict) {
                XCTFail("MockMultiSearchTreeStressTests.testMiniStressAddAndRemoveOne \(arrayAdd) failed")
                return
            }
            
            removeOneFromBoth(tree: tree, dict: &dict, data: arrayRemove)
            if !compare(tree: tree, dict: dict) {
                XCTFail("MockMultiSearchTreeStressTests.testMiniStressAddAndRemoveOne \(arrayAdd) failed")
                return
            }
        }
    }
    
    func testMiniStressAddAndRemoveAll() {
        for _ in 0..<10000 {
            let arrayAdd = miniArray()
            let arrayRemove = miniArray()
            
            var dict = [Int: Int]()
            let tree = MockMultiSearchTree<Int>()
            addToBoth(tree: tree, dict: &dict, data: arrayAdd)
            if !compare(tree: tree, dict: dict) {
                XCTFail("MockMultiSearchTreeStressTests.testMiniStressAddAndRemoveOne \(arrayAdd) failed")
                return
            }
            
            removeAllFromBoth(tree: tree, dict: &dict, data: arrayRemove)
            if !compare(tree: tree, dict: dict) {
                XCTFail("MockMultiSearchTreeStressTests.testMiniStressAddAndRemoveOne \(arrayAdd) failed")
                return
            }
        }
    }
    
    func testAdd100ComparingEveryTime_100Times() {
        for _ in 0..<100 {
            var insert = [Int]()
            for _ in 0..<100 { insert.append(Int.random(in: 0...100)) }
            
            var dict = [Int: Int]()
            let tree = MockMultiSearchTree<Int>()
            
            for value in insert {
                addToBoth(tree: tree, dict: &dict, element: value)
                if !compare(tree: tree, dict: dict) {
                    XCTFail("MockMultiSearchTreeStressTests.testAdd100ComparingEveryTime_100Times \(insert) failed")
                    return
                }
            }
        }
    }
    
    func testAdd100DeleteOne100ComparingEveryTime_100Times() {
        for _ in 0..<100 {
            var insert = [Int]()
            for _ in 0..<100 { insert.append(Int.random(in: 0...100)) }
            
            var remove = [Int]()
            for _ in 0..<100 { remove.append(Int.random(in: 0...100)) }
            
            var dict = [Int: Int]()
            let tree = MockMultiSearchTree<Int>()
            
            for value in insert {
                addToBoth(tree: tree, dict: &dict, element: value)
            }
            
            for value in remove {
                removeOneFromBoth(tree: tree, dict: &dict, element: value)
                if !compare(tree: tree, dict: dict) {
                    XCTFail("MockMultiSearchTreeStressTests.testAdd100DeleteOne100ComparingEveryTime_100Times insert: \(insert) failed")
                    XCTFail("MockMultiSearchTreeStressTests.testAdd100DeleteOne100ComparingEveryTime_100Times remove: \(remove) failed")
                    return
                }
            }
        }
    }
    
    func testAdd100DeleteAll100ComparingEveryTime_100Times() {
        for _ in 0..<100 {
            var insert = [Int]()
            for _ in 0..<100 { insert.append(Int.random(in: 0...100)) }
            
            var remove = [Int]()
            for _ in 0..<100 { remove.append(Int.random(in: 0...100)) }
            
            var dict = [Int: Int]()
            let tree = MockMultiSearchTree<Int>()
            
            for value in insert {
                addToBoth(tree: tree, dict: &dict, element: value)
            }
            
            for value in remove {
                removeAllFromBoth(tree: tree, dict: &dict, element: value)
                if !compare(tree: tree, dict: dict) {
                    XCTFail("MockMultiSearchTreeStressTests.testAdd100DeleteAll100ComparingEveryTime_100Times insert: \(insert) failed")
                    XCTFail("MockMultiSearchTreeStressTests.testAdd100DeleteAll100ComparingEveryTime_100Times remove: \(remove) failed")
                    return
                }
            }
        }
    }
    
}
