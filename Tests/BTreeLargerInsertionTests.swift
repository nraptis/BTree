//
//  BTreeLargerInsertionTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/30/22.
//

import XCTest
@testable import TreeTests

final class BTreeLargerInsertionTests: XCTestCase {

    func checkForwardsIterator(tree: BTree<Int>, array: [Int]) -> Bool {
        guard tree.count == array.count else {
            XCTFail("BTreeLargerInsertionTests.checkForwardsIterator() tree.count (\(tree.count)) != array.count (\(array.count))")
            return false
        }
        if array.count == 0 {
            guard tree.begin() == tree.end() else {
                XCTFail("BTreeLargerInsertionTests.checkForwardsIterator() tree.begin() != tree.end() at count 0")
                return false
            }
        }
        let array = array.sorted()
        let iterator = tree.begin()
        let end = tree.end()
        var index = 0
        if let node = iterator.node, node.count <= 0 {
            XCTFail("BTreeLargerInsertionTests.checkForwardsIterator() node.count (\(node.count)) <= 0 (I)")
            return false
        }
        while iterator != end && index < array.count {
            if let node = iterator.node, node.count <= 0 {
                XCTFail("BTreeLargerInsertionTests.checkForwardsIterator() node.count (\(node.count)) <= 0 (II)")
                return false
            }
            iterator.increment()
            index += 1
        }
        guard iterator == end else {
            XCTFail("BTreeLargerInsertionTests.checkForwardsIterator() iterator != end")
            return false
        }
        if index != array.count {
            XCTFail("BTreeLargerInsertionTests.checkForwardsIterator() index (\(index)) != array.count (\(array.count))")
            return false
        }
        return true
    }
    
    func checkBackwardsIterator(tree: BTree<Int>, array: [Int]) -> Bool {
        
        guard tree.count == array.count else {
            XCTFail("BTreeLargerInsertionTests.checkBackwardsIterator() tree.count (\(tree.count)) != array.count (\(array.count))")
            return false
        }
        
        if array.count == 0 {
            guard tree.begin() == tree.end() else {
                XCTFail("BTreeLargerInsertionTests.checkBackwardsIterator() tree.begin() != tree.end() at count 0")
                return false
            }
        }
        
        let array = array.sorted()
        let iterator = tree.end()
        let begin = tree.begin()
        var index = array.count
        
        while iterator != begin && index > 0 {
            iterator.decrement()
            if let node = iterator.node, node.count <= 0 {
                XCTFail("BTreeLargerInsertionTests.checkBackwardsIterator() node.count (\(node.count)) <= 0 (I)")
                return false
            }
            index -= 1
            if iterator.value() != array[index] {
                XCTFail("BTreeLargerInsertionTests.checkBackwardsIterator() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return false
            }
        }
        guard iterator == begin else {
            XCTFail("BTreeLargerInsertionTests.checkBackwardsIterator() iterator != begin")
            return false
        }
        if index > 0 {
            XCTFail("BTreeLargerInsertionTests.checkBackwardsIterator() index (\(index)) != 0")
            return false
        }
        return true
    }
    
    func testAdd0to1000Order3() {
        let order = 3
        let tree = BTree<Int>(order: order)
        var array = [Int]()
        var index = 0
        while index <= 1000 {
            
            array.append(index)
            tree.insert(index)
            
            if !checkForwardsIterator(tree: tree, array: array) {
                tree.printLevels()
                XCTFail("BTreeIteratorSimpleTests.testAdd0to1000Order3() forwards iterator array: \(array)")
                return
            }
            if !checkBackwardsIterator(tree: tree, array: array) {
                tree.printLevels()
                XCTFail("BTreeIteratorSimpleTests.testAdd0to1000Order3() backwards iterator array: \(array)")
                return
            }
            
            index += 1
        }
    }
    
    func testAdd0to100With10PermutationsOrder3() {
        let order = 3
        var array = [Int]()
        var index = 0
        while index <= 100 {
            array.append(index)
            let permutations = array.permutations(maxCount: 10, maxTries: 10)
            for permutation in permutations {
                let tree = BTree<Int>(order: order)
                for value in array {
                    tree.insert(value)
                }
                if !checkForwardsIterator(tree: tree, array: permutation) {
                    tree.printLevels()
                    XCTFail("BTreeIteratorSimpleTests.testAdd0to100With100PermutationsOrder3() forwards iterator permutation: \(permutation)")
                    return
                }
                if !checkBackwardsIterator(tree: tree, array: permutation) {
                    tree.printLevels()
                    XCTFail("BTreeIteratorSimpleTests.testAdd0to100With100PermutationsOrder3() backwards iterator permutation: \(permutation)")
                    return
                }
            }
            index += 1
        }
    }
    
    func testAdd0to100With10PermutationsOrder50() {
        let order = 50
        var array = [Int]()
        var index = 0
        while index <= 100 {
            array.append(index)
            let permutations = array.permutations(maxCount: 10, maxTries: 10)
            for permutation in permutations {
                let tree = BTree<Int>(order: order)
                for value in array {
                    tree.insert(value)
                }
                if !checkForwardsIterator(tree: tree, array: permutation) {
                    tree.printLevels()
                    XCTFail("BTreeIteratorSimpleTests.testAdd0to100With100PermutationsOrder50() forwards iterator permutation: \(permutation)")
                    return
                }
                if !checkBackwardsIterator(tree: tree, array: permutation) {
                    tree.printLevels()
                    XCTFail("BTreeIteratorSimpleTests.testAdd0to100With100PermutationsOrder50() backwards iterator permutation: \(permutation)")
                    return
                }
            }
            index += 1
        }
    }
    
    func testAdd0to100With10PermutationsOrder255() {
        let order = 255
        var array = [Int]()
        var index = 0
        while index <= 100 {
            array.append(index)
            let permutations = array.permutations(maxCount: 10, maxTries: 10)
            for permutation in permutations {
                let tree = BTree<Int>(order: order)
                for value in array {
                    tree.insert(value)
                }
                if !checkForwardsIterator(tree: tree, array: permutation) {
                    tree.printLevels()
                    XCTFail("BTreeIteratorSimpleTests.testAdd0to100With100PermutationsOrder255() forwards iterator permutation: \(permutation)")
                    return
                }
                if !checkBackwardsIterator(tree: tree, array: permutation) {
                    tree.printLevels()
                    XCTFail("BTreeIteratorSimpleTests.testAdd0to100With100PermutationsOrder255() backwards iterator permutation: \(permutation)")
                    return
                }
            }
            index += 1
        }
    }
    
    func testAdd0to60With10PermutationsOrder3to12() {
        var order = 3
        while order < 12 {
            print("testAdd0to60With25PermutationsOrder3to24() order = \(order)")
            var array = [Int]()
            var index = 0
            while index <= 60 {
                array.append(index)
                let permutations = array.permutations(maxCount: 10, maxTries: 20)
                for permutation in permutations {
                    let tree = BTree<Int>(order: order)
                    for value in array {
                        tree.insert(value)
                    }
                    if !checkForwardsIterator(tree: tree, array: permutation) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testAdd0to60With25PermutationsOrder3to24() forwards iterator permutation: \(permutation)")
                        return
                    }
                    if !checkBackwardsIterator(tree: tree, array: permutation) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testAdd0to60With25PermutationsOrder3to24() backwards iterator permutation: \(permutation)")
                        return
                    }
                }
                index += 1
            }
            order += 1
        }
    }
    
    func testAdd0to60With10PermutationsOrder3to12RandomDupes() {
        var order = 3
        while order < 12 {
            print("testAdd0to60With25PermutationsOrder3to24RandomDupes() order = \(order)")
            var array = [Int]()
            var index = 0
            while index <= 60 {
                array.append(index)
                if Bool.random() { array.append(index) }
                if Bool.random() { array.append(index) }
                
                let permutations = array.permutations(maxCount: 10, maxTries: 20)
                for permutation in permutations {
                    let tree = BTree<Int>(order: order)
                    for value in array {
                        tree.insert(value)
                    }
                    if !checkForwardsIterator(tree: tree, array: permutation) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testAdd0to60With25PermutationsOrder3to24RandomDupes() forwards iterator permutation: \(permutation)")
                        return
                    }
                    if !checkBackwardsIterator(tree: tree, array: permutation) {
                        tree.printLevels()
                        XCTFail("BTreeIteratorSimpleTests.testAdd0to60With25PermutationsOrder3to24RandomDupes() backwards iterator permutation: \(permutation)")
                        return
                    }
                }
                index += 1
            }
            order += 1
        }
    }
    
    
    
    
    
    //
    //let realTree = BTree<Int>(order: 4)
    //let mockTree = MockMultiSearchTree<Int>()
}
