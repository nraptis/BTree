//
//  BBTreeInsertAndDeleteStressTests.swift
//  Tests
//
//  Created by Nicky Taylor on 12/2/22.
//

import XCTest
@testable import TreeTests

final class BBTreeInsertAndDeleteStressTests: XCTestCase {
    
    //Assumption: "Mock Tree Works as Expected!" (Axiom)
    func compare(mockTree: MockMultiSearchTree<Int>, realTree: BTree<Int>) -> Bool {
        
        if mockTree.count != realTree.count {
            XCTFail("BBTreeInsertAndDeleteStressTests.compare() mockTree.count: (\(mockTree.count)) realTree.count: (\(realTree.count))")
            return false
        }
        
        let allUniqueElements = Array(Set(mockTree.data))
        for value in allUniqueElements {
            
            if !realTree.contains(value) {
                XCTFail("BBTreeInsertAndDeleteStressTests.compare() real tree does not contain: (\(value))")
                return false
            }
            
            if realTree.countElement(value) != mockTree.countElement(value) {
                XCTFail("BBTreeInsertAndDeleteStressTests.compare() value: \(value) realTreeCount: \(realTree.countElement(value)) mockTreeCount: \(mockTree.countElement(value))")
                return false
            }
        }
        return true
    }
    
    
    func testInsertAndDeleteOneElement() {
        
        let mockTree = MockMultiSearchTree<Int>()
        let realTree = BTree<Int>(order: 3)
        
        mockTree.insert(42)
        realTree.insert(42)
        
        if !compare(mockTree: mockTree, realTree: realTree) {
            XCTFail("BBTreeInsertAndDeleteStressTests.testInsertAndDeleteOneElement()")
            return
        }
        
        mockTree.remove(42)
        realTree.remove(42)
        
        if !compare(mockTree: mockTree, realTree: realTree) {
            XCTFail("BBTreeInsertAndDeleteStressTests.testInsertAndDeleteOneElement()")
            return
        }
    }
    
    func testInsertAndDeleteUpTo100Elements1000Times() {
        for _ in 0..<1000 {
            var insertArray = [Int]()
            var insertCount = Int.random(in: 0...100)
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...100))
            }
            
            var deleteArray = [Int]()
            var deleteCount = Int.random(in: 0...100)
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...100))
            }
            
            let mockTree = MockMultiSearchTree<Int>()
            let realTree = BTree<Int>(order: 3)
            
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
                if !compare(mockTree: mockTree, realTree: realTree) {
                    print("insert: \(insertArray)")
                    print("remove: \(deleteArray)")
                    
                    XCTFail("BBTreeInsertAndDeleteStressTests.testInsertAndDeleteUpTo1000Elements1000Times()")
                    return
                }
            }
        }
    }
    
    func testInsertAndDeleteUpTo50Elements50TimesOrder3to12() {
        for order in 3...12 {
            for _ in 0..<50 {
                var insertArray = [Int]()
                var insertCount = Int.random(in: 0...50)
                for _ in 0..<insertCount {
                    insertArray.append(Int.random(in: 0...50))
                }
                
                var deleteArray = [Int]()
                var deleteCount = Int.random(in: 0...50)
                for _ in 0..<deleteCount {
                    deleteArray.append(Int.random(in: 0...50))
                }
                
                let mockTree = MockMultiSearchTree<Int>()
                let realTree = BTree<Int>(order: order)
                
                for value in insertArray {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                
                for value in deleteArray {
                    realTree.remove(value)
                    mockTree.remove(value)
                    if !compare(mockTree: mockTree, realTree: realTree) {
                        XCTFail("BBTreeInsertAndDeleteStressTests.testInsertAndDeleteUpTo100Elements1000TimesOrder3to50()")
                        return
                    }
                }
            }
        }
    }
    

}
