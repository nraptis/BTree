//
//  BTreeCountingDuplicateItemsTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/30/22.
//

import XCTest
@testable import TreeTests

final class BTreeInsertAndCountTests: XCTestCase {

    func compareTrees(realTree: BTree<Int>, mockTree: MockMultiSearchTree<Int>) -> Bool {
        if realTree.count != mockTree.count {
            XCTFail("BTreeInsertAndCountTests.compareTrees() realTree.count (\(realTree.count)) != mockTree.count \(mockTree.count)")
            return false
        }
        
        let uniqueNumbers = Set<Int>(mockTree.data)
        let uniqueArray = Array(uniqueNumbers)
        
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
        return true
    }
    //
    
    func testInsertSingle1() {
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        realTree.insert(1)
        mockTree.insert(1)
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testInsertSingle1()")
            return
        }
    }
    
    func testInsertSingle1to10() {
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
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10() array: \(array)")
                return
            }
        }
    }
    
    func testInsertDuplicate1() {
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        realTree.insert(1)
        realTree.insert(1)
        mockTree.insert(1)
        mockTree.insert(1)
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testInsertDuplicate1()")
            return
        }
    }
    
    func testInsertDuplicate1to10() {
        for loop in 1...10 {
            var array = [Int]()
            for index in 0...loop {
                array.append(index)
            }
            let realTree = BTree<Int>(order: 3)
            let mockTree = MockMultiSearchTree<Int>()
            for value in array {
                realTree.insert(value)
                realTree.insert(value)
                mockTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                XCTFail("BTreeInsertAndCountTests.testInsertDuplicate1to10() array: \(array)")
                return
            }
        }
    }
    
    func testInsertAllSubsetsDupes1to4() {
        
        let seed = [1, 1, 2, 2, 3, 3, 4, 4]
        let subsets = seed.allSubsets()
        
        for subset in subsets {
            let realTree = BTree<Int>(order: 3)
            let mockTree = MockMultiSearchTree<Int>()
            for value in subset {
                realTree.insert(value)
                realTree.insert(value)
                mockTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                XCTFail("BTreeInsertAndCountTests.testInsertAllSubsetsDupes1to4() subset: \(subset)")
                return
            }
        }
    }
    
    func testInsertAllSubsetsDupes1to4AllPermutations() {
        let seed = [1, 1, 2, 2, 3, 3, 4, 4]
        let subsets = seed.allSubsets()
        for subset in subsets {
            
            let permutations = subset.allPermutations()
            for permutation in permutations {
                let realTree = BTree<Int>(order: 3)
                let mockTree = MockMultiSearchTree<Int>()
                for value in permutation {
                    realTree.insert(value)
                    realTree.insert(value)
                    mockTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.testInsertAllSubsetsDupes1to4AllPermutations() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func test1000RandomArraysWithManyDupes() {
        for _ in 0..<1000 {
            var count1 = 0
            if Bool.random() { count1 = Int.random(in: 0...100) }
            
            var count2 = 0
            if Bool.random() { count2 = Int.random(in: 0...100) }
            
            var count3 = 0
            if Bool.random() { count3 = Int.random(in: 0...100) }
            
            var array = [Int]()
            for _ in 0..<count1 { array.append(0) }
            for _ in 0..<count2 { array.append(1) }
            for _ in 0..<count3 { array.append(2) }
            
            let realTree = BTree<Int>(order: 4)
            let mockTree = MockMultiSearchTree<Int>()
            for value in array {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                XCTFail("BTreeInsertAndCountTests.test1000RandomArraysWithManyDupes() array: \(array)")
                return
            }
        }
    }
    
    func test4RandomArraysWithManyDupes50Permutations() {
        for _ in 0..<10000 {
            var count1 = 0
            if Bool.random() { count1 = Int.random(in: 5...7) }
            
            var count2 = 0
            if Bool.random() { count2 = Int.random(in: 5...7) }
            
            var count3 = 0
            if Bool.random() { count3 = Int.random(in: 5...7) }
            
            var array = [Int]()
            for _ in 0..<count1 { array.append(0) }
            for _ in 0..<count2 { array.append(1) }
            for _ in 0..<count3 { array.append(2) }
            
            let permutations = array.permutations(maxCount: 50, maxTries: 75)
            
            for permutation in permutations {
                
                let realTree = BTree<Int>(order: 3)
                let mockTree = MockMultiSearchTree<Int>()
                for value in permutation {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.test100RandomArraysWithManyDupes50Permutations() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func test100RandomArraysWithManyDupes50Permutations() {
        for test in 0..<100 {
            var count1 = 0
            if Bool.random() { count1 = Int.random(in: 0...100) }
            
            var count2 = 0
            if Bool.random() { count2 = Int.random(in: 0...100) }
            
            var count3 = 0
            if Bool.random() { count3 = Int.random(in: 0...100) }
            
            var array = [Int]()
            for i in 0..<count1 { array.append(0) }
            for i in 0..<count2 { array.append(1) }
            for i in 0..<count3 { array.append(2) }
            
            let permutations = array.permutations(maxCount: 50, maxTries: 75)
            
            for permutation in permutations {
                
                let realTree = BTree<Int>(order: 3)
                let mockTree = MockMultiSearchTree<Int>()
                for value in permutation {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.test100RandomArraysWithManyDupes50Permutations() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func testKnownFailureCase01() {
        let order = 3
        let array = [2, 0, 2, 1, 2, 2, 1, 1, 0, 1]
        let realTree = BTree<Int>(order: order)

        let mockTree = MockMultiSearchTree<Int>()
        
        for (index, value) in array.enumerated() {
            
            realTree.insert(value)
            mockTree.insert(value)
            
            realTree.printLevels()
            print("Index[\(index)] = \(value)")
            
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.test1000RandomArraysWithManyDupes() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase02() {
        let order = 3
        let array = [2, 1, 1, 0, 0, 0, 1, 2, 2, 0, 1, 0, 2, 2, 0, 0, 1, 0]
        let realTree = BTree<Int>(order: order)

        let mockTree = MockMultiSearchTree<Int>()
        
        for (index, value) in array.enumerated() {
            
            realTree.insert(value)
            mockTree.insert(value)
            
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.test1000RandomArraysWithManyDupes() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase03() {
        let order = 3
        let array = [2, 1, 1, 0, 0, 0, 1, 2, 2, 0, 1, 0, 2, 2, 0, 0, 1, 0]
        let realTree = BTree<Int>(order: order)

        let mockTree = MockMultiSearchTree<Int>()
        
        for (index, value) in array.enumerated() {
            
            realTree.insert(value)
            mockTree.insert(value)
            
            realTree.printLevels()
            print("Index[\(index)] = \(value)")
            
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.test1000RandomArraysWithManyDupes() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase04() {
        let order = 3
        let array = [2, 2, 1, 1, 0, 2, 1, 1, 0, 1, 2, 0, 1, 0, 2, 0, 2, 1, 0, 2, 0]
        let realTree = BTree<Int>(order: order)

        let mockTree = MockMultiSearchTree<Int>()
        
        for (index, value) in array.enumerated() {
            
            realTree.insert(value)
            mockTree.insert(value)
            
            realTree.printLevels()
            print("Index[\(index)] = \(value)")
            
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.test1000RandomArraysWithManyDupes() array: \(array)")
            return
        }
    }
    
    
    
    
    func testKnownFailureCase100000() {
        let order = 4
        let array = [2, 2, 0, 0, 2, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2, 2, 0, 0, 0, 2, 2, 2, 2, 0, 2, 2, 0, 0, 2, 0, 0, 0, 2, 2, 2, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 0, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()

        for (index, value) in array.enumerated() {
            print("Index[\(index)] = \(value)")
            if index == 38 {
                realTree.printLevels()
            }
            realTree.insert(value)
        }
    }
    
}
