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
        if array.count == 0 {
            guard tree.startIterator() == tree.endIterator() else {
                XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() tree.startIterator() != tree.endIterator() at count 0")
                return false
            }
        }
        let array = array.sorted()
        let iterator = tree.startIterator()
        let end = tree.endIterator()
        var index = 0
        if let node = iterator.node, node.count <= 0 {
            XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() node.count (\(node.count)) <= 0 (I)")
            return false
        }
        while iterator != end && index < array.count {
            if let node = iterator.node, node.count <= 0 {
                XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() node.count (\(node.count)) <= 0 (II)")
                return false
            }
            iterator.increment()
            index += 1
        }
        guard iterator == end else {
            XCTFail("BTreeSimpleInsertionTests.checkForwardsIterator() iterator != end")
            return false
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
        
        if array.count == 0 {
            guard tree.startIterator() == tree.endIterator() else {
                XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() tree.startIterator() != tree.endIterator() at count 0")
                return false
            }
        }
        
        let array = array.sorted()
        let iterator = tree.endIterator()
        let begin = tree.startIterator()
        var index = array.count
        
        while iterator != begin && index > 0 {
            iterator.decrement()
            if let node = iterator.node, node.count <= 0 {
                XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() node.count (\(node.count)) <= 0 (I)")
                return false
            }
            index -= 1
            if iterator.value() != array[index] {
                XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return false
            }
        }
        guard iterator == begin else {
            XCTFail("BTreeSimpleInsertionTests.checkBackwardsIterator() iterator != begin")
            return false
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
    
    func testInsert_0_10_ValuesAndIterateOrder_3_10() {
        for order in 3...10 {
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
                    XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_3_10() forwards iterator array: \(array)")
                    return
                }
                if !checkBackwardsIterator(tree: tree, array: array) {
                    XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_3_10() backwards iterator array: \(array)")
                    return
                }
            }
        }
    }
    
    func testInsert_0_8_ValuesAndIterateOrder_3_8_AllPermutations() {
        for order in 3...8 {
            for count in 0...8 {
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
                    
                    if !checkForwardsIterator(tree: tree, array: arrayBase) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_3_10_AllPermutations() forwards iterator permutation: \(permutation)")
                        return
                    }
                    
                    if !checkBackwardsIterator(tree: tree, array: arrayBase) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testInsert_0_10_ValuesAndIterateOrder_3_10_AllPermutations() backwards iterator permutation: \(permutation)")
                        return
                    }
                }
            }
        }
    }
    
    func testKnownFailureCase01() {
        
        let order = 3
        let array = [0, 1, 2, 3, 4]
        let tree = BTree<Int>(order: order)
        
        tree.insert(0); tree.insert(1); tree.insert(2);
        tree.insert(3); tree.insert(4)
        
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
        
        let order = 3
        let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let tree = BTree<Int>(order: order)
        
        tree.insert(0); tree.insert(1); tree.insert(2); tree.insert(3)
        tree.insert(4); tree.insert(5); tree.insert(6); tree.insert(7)
        tree.insert(8); tree.insert(9)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase02() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase02() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase03() {
        
        let order = 3
        let array = [1, 0]
        let tree = BTree<Int>(order: order)
        tree.insert(1); tree.insert(0)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase03() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase03() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase04() {
        let order = 3
        let array = [0, 2, 1]
        let tree = BTree<Int>(order: order)
        tree.insert(0); tree.insert(2); tree.insert(1)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase04() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase04() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase05() {
        let order = 3
        let array = [1, 0, 2]
        let tree = BTree<Int>(order: order)
        
        tree.insert(1); tree.insert(0)
        tree.insert(2)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase05() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase05() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase06() {
        
        let order = 3
        let array = [1, 2, 0]
        let tree = BTree<Int>(order: order)
        
        tree.insert(1); tree.insert(2)
        tree.insert(0)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase06() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase06() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase07() {
        let order = 3
        let array = [0, 2, 3, 1]
        let tree = BTree<Int>(order: order)
        tree.insert(0); tree.insert(2); tree.insert(3)
        tree.insert(1)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase07() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase07() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase08() {
        let order = 3
        let array = [2, 3, 1, 0]
        let tree = BTree<Int>(order: order)
        tree.insert(2); tree.insert(3); tree.insert(1); tree.insert(0)
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase08() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase08() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase09() {
        let order = 3
        let array = [0, 1, 2, 3, 5, 4]
        let tree = BTree<Int>(order: order)
        tree.insert(0); tree.insert(1); tree.insert(2)
        tree.insert(3); tree.insert(5); tree.insert(4)
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase09() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase09() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase10() {
        let order = 3
        let array = [0, 1, 3, 6, 7, 4, 5, 2]
        let tree = BTree<Int>(order: order)
        tree.insert(0); tree.insert(1); tree.insert(3); tree.insert(6)
        tree.insert(7); tree.insert(4); tree.insert(5); tree.insert(2)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase10() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase10() backwards iterator array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase11() {
        let order = 4
        let array = [0, 1, 2, 4, 3, 5, 6]
        let tree = BTree<Int>(order: order)
        
        tree.insert(0); tree.insert(1); tree.insert(2)
        tree.insert(4); tree.insert(3); tree.insert(5)
        tree.insert(6)
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase11() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testKnownFailureCase11() backwards iterator array: \(array)")
            return
        }
    }
}
