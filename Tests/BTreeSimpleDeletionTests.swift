//
//  BTreeSimpleDeletionTests.swift
//  Tests
//
//  Created by Nicky Taylor on 12/1/22.
//

import XCTest
@testable import TreeTests

final class BTreeSimpleDeletionTests: XCTestCase {

    func compareTrees(realTree: BTree<Int>, mockTree: MockMultiSearchTree<Int>) -> Bool {
        if realTree.count != mockTree.count {
            XCTFail("BTreeInsertAndCountTests.compareTrees() realTree.count (\(realTree.count)) != mockTree.count \(mockTree.count)")
            return false
        }
        
        if mockTree.count <= 0 {
            return true
        }
        
        let uniqueNumbers = Set<Int>(mockTree.data)
        let uniqueArray = Array(uniqueNumbers)
        
        // check all the elements that di exist...
        for number in uniqueArray {
            if realTree.contains(number) != mockTree.contains(number) {
                realTree.printLevels()
                print("Mock: \(mockTree.data)")
                XCTFail("BTreeInsertAndCountTests.compareTrees() number (\(number)) exists in btree: \(realTree.contains(number))) exists in mock tree: \(mockTree.contains(number))")
                return false
            }
            
            if realTree.countElement(number) != mockTree.countElement(number) {
                realTree.printLevels()
                print("Mock: \(mockTree.data)")
                XCTFail("BTreeInsertAndCountTests.compareTrees() realTree.countElement(number (\(number))) (\(realTree.countElement(number))) != mockTree.countElement(number (\(number)) (\(mockTree.countElement(number)))")
                return false
            }
        }
        
        // check elements that don't exist too...
        if let minNumber = uniqueArray.min(), let maxNumber = uniqueArray.max() {
            let start = minNumber - 10
            let end = maxNumber + 10
            if start < end {
                for check in start...end {
                    
                    if realTree.contains(check) != mockTree.contains(check) {
                        realTree.printLevels()
                        print("Mock: \(mockTree.data)")
                        XCTFail("BTreeInsertAndCountTests.compareTrees() number (\(check)) exists in btree: \(realTree.contains(check))) exists in mock tree: \(mockTree.contains(check))")
                        return false
                    }
                    
                    if realTree.countElement(check) != mockTree.countElement(check) {
                        realTree.printLevels()
                        print("Mock: \(mockTree.data)")
                        XCTFail("BTreeInsertAndCountTests.compareTrees() realTree.countElement(number (\(check))) (\(realTree.countElement(check))) != mockTree.countElement(number (\(check)) (\(mockTree.countElement(check)))")
                        return false
                    }
                    
                }
            }
        }
        return true
    }
    
    func testInsert1Delete1() {
        
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        
        realTree.insert(1)
        mockTree.insert(1)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            realTree.printLevels()
            XCTFail("BTreeInsertAndCountTests.testInsert1Delete1()")
            return
        }
        
        realTree.remove(1)
        mockTree.remove(1)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            realTree.printLevels()
            XCTFail("BTreeInsertAndCountTests.testInsert1Delete1()")
            return
        }
    }
    
    func testInsertSingle1to10_Remove1to10() {
        for loop in 1...10 {
            var array = [Int]()
            for index in 0...loop {
                array.append(index)
            }
            let realTree = BTree<Int>(order: 3)
            let mockTree = MockMultiSearchTree<Int>()
            for value in array {
                realTree.insert(value)
                mockTree.insert(value)
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10() array: \(array)")
                    return
                }
            }
            for value in array {
                realTree.remove(value)
                mockTree.remove(value)
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10() array: \(array)")
                    return
                }
            }
        }
    }
    
    func testInsertSingle1to5_AllPermutationsInserted_AllPermutationsRemoved() {
        for loop in 1..<5 {
            var array = [Int]()
            for index in 0...loop {
                array.append(index)
            }
            
            let permutations = array.allPermutations()
            var index = 0
            for insertPermutation in permutations {
                index += 1
                for removePermutation in permutations {
                    let realTree = BTree<Int>(order: 3)
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    for value in removePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                        if !compareTrees(realTree: realTree, mockTree: mockTree) {
                            XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved() insertPermutation: \(insertPermutation) removePermutation: \(removePermutation)")
                            return
                        }
                    }
                }
            }
        }
    }
    
    func testInsertSingle1to10_50PermutationsInserted_25PermutationsRemoved() {
        for loop in 1...10 {
            print("testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved count \(loop) / 10")
            var array = [Int]()
            for index in 0...loop {
                array.append(index)
            }
            let insertPermutations = array.permutations(maxCount: 50, maxTries: 75)
            for insertPermutation in insertPermutations {
                let removePermutations = array.permutations(maxCount: 25, maxTries: 30)
                for removePermutation in removePermutations {
                    
                    let realTree = BTree<Int>(order: Int.random(in: 3...10))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    for value in removePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                        if !compareTrees(realTree: realTree, mockTree: mockTree) {
                            XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved() insertPermutation: \(insertPermutation) removePermutation: \(removePermutation)")
                            return
                        }
                    }
                }
            }
        }
    }
    
    func testInsertSingle16to24_50PermutationsInserted_25PermutationsRemoved() {
        for loop in 16...24 {
            print("testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved count \(loop) / 24")
            var array = [Int]()
            for index in 0...loop {
                array.append(index)
            }
            
            let insertPermutations = array.permutations(maxCount: 50, maxTries: 35)
            for insertPermutation in insertPermutations {
                
                let removePermutations = array.permutations(maxCount: 25, maxTries: 35)
                for removePermutation in removePermutations {
                    
                    let realTree = BTree<Int>(order: Int.random(in: 3...10))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    for value in removePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                        if !compareTrees(realTree: realTree, mockTree: mockTree) {
                            XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved() insertPermutation: \(insertPermutation) removePermutation: \(removePermutation)")
                            return
                        }
                    }
                    
                }
            }
        }
    }
    
    func testInsertSingle40to44_20PermutationsInserted_10PermutationsRemoved() {
        for loop in 40...44 {
            
            print("testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved count \(loop) / 44")
            
            var array = [Int]()
            for index in 0...loop {
                array.append(index)
            }
            
            let insertPermutations = array.permutations(maxCount: 20, maxTries: 25)
            for insertPermutation in insertPermutations {
                
                let removePermutations = array.permutations(maxCount: 10, maxTries: 15)
                for removePermutation in removePermutations {
                    
                    let realTree = BTree<Int>(order: Int.random(in: 3...10))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    for value in removePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                        if !compareTrees(realTree: realTree, mockTree: mockTree) {
                            XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10_100PermutationsInserted_100PermutationsRemoved() insertPermutation: \(insertPermutation) removePermutation: \(removePermutation)")
                            return
                        }
                    }
                }
            }
        }
    }
    
    func testKnownFailureCase01() {
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        realTree.insert(0); realTree.insert(3); realTree.insert(2); realTree.insert(1)
        mockTree.insert(0); mockTree.insert(3); mockTree.insert(2); mockTree.insert(1)
        
        realTree.remove(0)
        mockTree.remove(0)
        
        realTree.remove(1)
        mockTree.remove(1)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase01()")
            return
        }
    }
    
    func testKnownFailureCase02() {
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        realTree.insert(0); realTree.insert(1); realTree.insert(2); realTree.insert(3)
        mockTree.insert(0); mockTree.insert(1); mockTree.insert(2); mockTree.insert(3)
        
        realTree.printLevels()
        realTree.remove(0)
        mockTree.remove(0)
        realTree.printLevels()
        
        realTree.remove(1)
        mockTree.remove(1)
        realTree.printLevels()
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase02()")
            return
        }
    }
    
    func testKnownFailureCase03() {
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        realTree.insert(0); realTree.insert(3); realTree.insert(2); realTree.insert(1)
        mockTree.insert(0); mockTree.insert(3); mockTree.insert(2); mockTree.insert(1)
        
        realTree.remove(2)
        mockTree.remove(2)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase03()")
            return
        }
        
        realTree.remove(1)
        mockTree.remove(1)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase03()")
            return
        }
        
        realTree.remove(0)
        mockTree.remove(0)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase03()")
            return
        }
        
        realTree.remove(3)
        mockTree.remove(3)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase03()")
            return
        }
    }
}
