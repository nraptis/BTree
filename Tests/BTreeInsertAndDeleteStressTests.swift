//
//  BBTreeInsertAndDeleteStressTests.swift
//  Tests
//
//  Created by Nicky Taylor on 12/2/22.
//

import XCTest
@testable import TreeTests

final class BTreeInsertAndDeleteStressTests: XCTestCase {
    
    //Assumption: "Mock Tree Works as Expected!" (Axiom)
    func compare(mockTree: MockMultiSearchTree<Int>, realTree: BTree<Int>) -> Bool {
        
        if mockTree.count != realTree.count {
            XCTFail("BTreeInsertAndDeleteStressTests.compare() mockTree.count: (\(mockTree.count)) realTree.count: (\(realTree.count))")
            return false
        }
        
        let allUniqueElements = Array(Set(mockTree.data))
        for value in allUniqueElements {
            
            if !realTree.contains(value) {
                XCTFail("BTreeInsertAndDeleteStressTests.compare() real tree does not contain: (\(value))")
                return false
            }
            
            if realTree.countElement(value) != mockTree.countElement(value) {
                XCTFail("BTreeInsertAndDeleteStressTests.compare() value: \(value) realTreeCount: \(realTree.countElement(value)) mockTreeCount: \(mockTree.countElement(value))")
                return false
            }
        }
        return true
    }
    
    func testInsertAndDeleteUpTo100Elements500Times() {
        for _ in 0..<500 {
            var insertArray = [Int]()
            let insertCount = Int.random(in: 0...100)
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...100))
            }
            
            var deleteArray = [Int]()
            let deleteCount = Int.random(in: 0...100)
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
                    
                    XCTFail("BTreeInsertAndDeleteStressTests.testInsertAndDeleteUpTo100Elements500Times()")
                    return
                }
            }
        }
    }
    
    func testInsertAndDeleteUpTo50Elements50TimesOrder3to12() {
        for order in 3...12 {
            for _ in 0..<50 {
                var insertArray = [Int]()
                let insertCount = Int.random(in: 0...50)
                for _ in 0..<insertCount {
                    insertArray.append(Int.random(in: 0...50))
                }
                
                var deleteArray = [Int]()
                let deleteCount = Int.random(in: 0...50)
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
                        XCTFail("BTreeInsertAndDeleteStressTests.testInsertAndDeleteUpTo50Elements50TimesOrder3to12()")
                        return
                    }
                }
            }
        }
    }
    
    func test100RandomMediumArraysStrict() {
        
        for _ in 0..<100 {
            let order = Int.random(in: 3...16)
            var insertArray = [Int]()
            let insertCount = Int.random(in: 0...200)
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...255))
            }
            
            var deleteArray = [Int]()
            let deleteCount = Int.random(in: 0...200)
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...255))
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
                    XCTFail("BTreeInsertAndDeleteStressTests.test100RandomMediumArraysStrict()")
                    return
                }
            }
        }
    }
    
    func test100RandomMediumArraysStrictThenDeletingAll() {
        
        for _ in 0..<100 {
            let order = Int.random(in: 3...16)
            var insertArray = [Int]()
            let insertCount = Int.random(in: 0...200)
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...255))
            }
            
            var deleteArray = [Int]()
            let deleteCount = Int.random(in: 0...200)
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...255))
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
                    XCTFail("BTreeInsertAndDeleteStressTests.test100RandomMediumArraysStrictThenDeletingAll()")
                    return
                }
            }
            
            let dataClone = mockTree.data
            
            for value in dataClone {
                realTree.remove(value)
                mockTree.remove(value)
                
                if !compare(mockTree: mockTree, realTree: realTree) {
                    XCTFail("BTreeInsertAndDeleteStressTests.test100RandomMediumArraysStrictThenDeletingAll()")
                    return
                }
            }
            
            guard realTree.count == 0 else {
                XCTFail("BTreeInsertAndDeleteStressTests.test100RandomMediumArraysStrictThenDeletingAll()")
                return
            }
        }
    }
    
    func test1000RandomMediumArraysOnlyComparingEndResult() {
        for _ in 0..<1000 {
            let order = Int.random(in: 3...16)
            
            var insertArray = [Int]()
            let insertCount = Int.random(in: 0...200)
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...255))
            }
            
            var deleteArray = [Int]()
            let deleteCount = Int.random(in: 0...200)
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...255))
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
            }
            
            if !compare(mockTree: mockTree, realTree: realTree) {
                XCTFail("BTreeInsertAndDeleteStressTests.test1000RandomMediumArraysStrict()")
                return
            }
        }
    }
}
