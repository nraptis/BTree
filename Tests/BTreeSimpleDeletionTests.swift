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
                realTree.printLevels()
                realTree.remove(value)
                mockTree.remove(value)
                realTree.printLevels()
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.testInsertSingle1to10() array: \(array)")
                    return
                }
            }
            
        }
    }
    
}
