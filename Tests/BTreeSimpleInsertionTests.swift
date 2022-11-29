//
//  BTreeSimpleInsertionTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/28/22.
//

import XCTest
@testable import TreeTests

final class BTreeSimpleInsertionTests: XCTestCase {

    func testInsertOneValue() {
        let tree = BTree<Int>(order: 3)
        tree.insert(10)
        
        guard let root = tree.root else {
            XCTFail("BTreeSimpleInsertionTests.testInsertOneValue missing root")
            return
        }
        
        guard root.value(index: 0) == 10 else {
            XCTFail("BTreeSimpleInsertionTests.testInsertOneValue expected 10 at root")
            return
        }
    }
    
    func checkForwardsIterator(tree: BTree<Int>, array: [Int]) -> Bool {
        guard tree.count == array.count else {
            XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() tree.count (\(tree.count)) != array.count (\(array.count))")
            return false
        }
        
        let iterator = tree.begin()
        let end = tree.end()
        var index = 0
        
        while let node = iterator.node, iterator != end, node.count <= 0 {
            iterator.increment()
        }
        
        while iterator != end {
            
            if iterator.value() != array[index] {
                XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return false
            }
            
            iterator.increment()
            
            while let node = iterator.node, iterator != end, node.count <= 0 {
                iterator.increment()
            }
            
            index += 1
        }
        if index != array.count {
            XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() index (\(index)) != array.count (\(array.count))")
            return false
        }
        
        return true
    }
    
    func checkBackwardsIterator(tree: BTree<Int>, array: [Int]) -> Bool {
        
        guard tree.count == array.count else {
            XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() tree.count (\(tree.count)) != array.count (\(array.count))")
            return false
        }
        
        let iterator = tree.end()
        let begin = tree.begin()
        var index = array.count
        
        while iterator != begin {
            iterator.decrement()
            
            while let node = iterator.node, iterator != begin, node.count <= 0 {
                iterator.decrement()
            }
            
            index -= 1
            
            if index >= 0 {
                if iterator.value() != array[index] {
                    XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                    return false
                }
            } else {
                print("checkBackwardsIterator, below range... \(index)")
                break
            }
        }
        if index > 0 {
            XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() index (\(index)) != 0")
            return false
        }
        
        return true
    }
    
    func testInsertOneValueAndIterate() {
        let tree = BTree<Int>(order: 3)
        tree.insert(10)
        let array = [10]
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() backwards iterator array: \(array)")
            return
        }
    }
    
    func testInsertTwoValuesAndIterateOrder3() {
        let tree = BTree<Int>(order: 3)
        tree.insert(1)
        tree.insert(2)
        
        let array = [1, 2]
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() backwards iterator array: \(array)")
            return
        }
    }
    
    func testInsertThreeValuesAndIterateOrder2() {
        let tree = BTree<Int>(order: 2)
        tree.insert(1); tree.insert(2); tree.insert(3)
        let array = [1, 2, 3]
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() backwards iterator array: \(array)")
            return
        }
    }
    
    func testInsert_0_10_ValuesAndIterateOrder_2_10() {
        for order in 2...10 {
            for count in 0...10 {
                let tree = BTree<Int>(order: order)
                var array = [Int]()
                var index = 0
                while index < count {
                    tree.insert(index)
                    array.append(index)
                    index += 1
                }
                
                if !checkForwardsIterator(tree: tree, array: array) {
                    XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_2_10() forwards iterator array: \(array)")
                    return
                }
                if !checkBackwardsIterator(tree: tree, array: array) {
                    XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_2_10() backwards iterator array: \(array)")
                    return
                }
            }
        }
    }
    
    func testInsert_0_10_ValuesAndIterateOrder_2_10_AllPermutations() {
        for order in 2...10 {
            for count in 0...10 {
                
                var arrayBase = [Int]()
                var index = 0
                while index < count {
                    
                    arrayBase.append(index)
                    index += 1
                }
                
                let permutations = arrayBase.allPermutations()
                for permutation in permutations {
                    let tree = BTree<Int>(order: order)
                    var index = 0
                    while index < count {
                        tree.insert(permutation[index])
                        index += 1
                    }
                    
                    print("permutation = \(permutation)")
                    
                    if !checkForwardsIterator(tree: tree, array: arrayBase) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_2_10() forwards iterator permutation: \(permutation)")
                        return
                    }
                    /*
                    if !checkBackwardsIterator(tree: tree, array: arrayBase) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_2_10() backwards iterator permutation: \(permutation)")
                        return
                    }
                    */
                }
            }
        }
    }
    
    func testKnownFailureCase01() {
        
        let order = 2
        let array = [0, 1, 2, 3, 4]
        let tree = BTree<Int>(order: order)
        
        tree.insert(0); tree.insert(1)
        tree.insert(2); tree.insert(3)
        tree.insert(4)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase02() {
        
        let order = 2
        let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let tree = BTree<Int>(order: order)
        
        tree.insert(0); tree.insert(1)
        tree.insert(2); tree.insert(3)
        tree.insert(4); tree.insert(5)
        tree.insert(6); tree.insert(7)
        tree.insert(8); tree.insert(9)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase03() {
        
        let order = 2
        let array = [1, 0]
        let tree = BTree<Int>(order: order)
        
        tree.insert(1)
        tree.insert(0)
        
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase04() {
        
        let order = 2
        let array = [0, 2, 1]
        let tree = BTree<Int>(order: order)
        
        tree.insert(0)
        tree.insert(2)
        tree.insert(1)
        
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase05() {
        
        let order = 2
        let array = [1, 0, 2]
        let tree = BTree<Int>(order: order)
        
        tree.insert(1); tree.insert(0)
        tree.insert(2)
        
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase06() {
        
        let order = 2
        let array = [1, 2, 0]
        let tree = BTree<Int>(order: order)
        
        tree.insert(1); tree.insert(2)
        tree.insert(0)
        
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase07() {
        
        let order = 2
        let array = [0, 2, 3, 1]
        let tree = BTree<Int>(order: order)
        tree.insert(0); tree.insert(2); tree.insert(3)
        tree.insert(1)
        
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase08() {
        let order = 2
        let array = [2, 3, 1, 0]
        let tree = BTree<Int>(order: order)
        tree.insert(2); tree.insert(3); tree.insert(1); tree.insert(0)
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase09() {
        let order = 2
        let array = [0, 1, 2, 3, 5, 4]
        let tree = BTree<Int>(order: order)
        tree.insert(0); tree.insert(1); tree.insert(2); tree.insert(3); tree.insert(5)
        
        tree.printLevels()
        tree.insert(4)
        
        tree.printLevels()
        
        if !checkForwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array.sorted()) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase01() backwards iterator array: \(array)")
            return
        }
    }
    
    
    
    
    
}
