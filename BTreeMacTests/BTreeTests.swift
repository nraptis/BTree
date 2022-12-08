//
//  BTreeTests.swift
//  BTreeTests
//
//  Created by Nicky Taylor on 12/4/22.
//

import XCTest
@testable import BTreeMac

final class BTreeTests: XCTestCase {
    
    func testSimpleOperations() {
        let realTree = BTree<Int>(order: 3)
        let mockTree = MockMultiSearchTree<Int>()
        for i in 1...6 {
            realTree.insert(i)
            mockTree.insert(i)
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: testSimpleOperations()")
                return
            }
        }
        for i in 1...6 {
            realTree.remove(i)
            mockTree.remove(i)
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: testSimpleOperations()")
                return
            }
        }
    }
    
    func testSmallTreeRigorously() {
        for order in 3...6 {
            for insertCount in 0...6 {
                var insertArray = [Int]()
                for index in 0..<insertCount {
                    insertArray.append(index)
                }
                
                let insertPermutations = insertArray.allPermutations()
                
                for deleteCount in 1...3 {
                    var deleteArray = [Int]()
                    for index in 0..<deleteCount {
                        deleteArray.append(index)
                    }
                    
                    let deletePermutations = deleteArray.allPermutations()
                    for insertPermutation in insertPermutations {
                        for deletePermutation in deletePermutations {
                            
                            let realTree = BTree<Int>(order: order)
                            let mockTree = MockMultiSearchTree<Int>()
                            for value in insertPermutation {
                                realTree.insert(value)
                                mockTree.insert(value)
                            }
                            
                            for value in deletePermutation {
                                realTree.remove(value)
                                mockTree.remove(value)
                            }
                            
                            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                                print("ins: \(insertPermutation)")
                                print("del: \(deletePermutation)")
                                
                                XCTFail("Failed: testSmallTreeRigorously()")
                                return
                            }
                        }
                    }
                }
            }
        }
    }

    func test10000SmallTrees() {
        for loop in 0...10000 {
            let insertCount = Int.random(in: 0...24)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...24))
            }
            
            let deleteCount = Int.random(in: 0...24)
            var deleteArray = [Int]()
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...24))
            }
            
            let realTree = BTree<Int>(order: Int.random(in: 3...16))
            let mockTree = MockMultiSearchTree<Int>()
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test10000SmallTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test10000SmallTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            if (loop % 1000) == 0 {
                print("test10000SmallTrees() [\(loop) / 10000]")
            }
        }
    }
    
    func test10000SmallTreesDeleteAll() {
        
        for loop in 0...10000 {
            let insertCount = Int.random(in: 0...24)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...24))
            }
            
            var deleteArray = insertArray
            deleteArray.shuffle()
            
            let realTree = BTree<Int>(order: Int.random(in: 3...16))
            let mockTree = MockMultiSearchTree<Int>()
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test10000SmallTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test10000SmallTreesDeleteAll()")
                return
            }
            
            if mockTree.count != 0 {
                XCTFail("Failed: test10000SmallTreesDeleteAll()")
            }
            
            if (loop % 1000) == 0 {
                print("test10000SmallTreesDeleteAll() [\(loop) / 10000]")
            }
        }
    }
    
    func test1000MediumTrees() {
        
        for loop in 0...1000 {
            let insertCount = Int.random(in: 0...128)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...64))
            }
            
            let deleteCount = Int.random(in: 0...128)
            var deleteArray = [Int]()
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...64))
            }
            
            let realTree = BTree<Int>(order: Int.random(in: 3...16))
            let mockTree = MockMultiSearchTree<Int>()
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test1000MediumTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test1000MediumTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            if (loop % 100) == 0 {
                print("test1000MediumTrees() [\(loop) / 1000]")
            }
        }
    }
    
    func test1000MediumTreesDeleteAll() {
        
        for loop in 0...1000 {
            let insertCount = Int.random(in: 0...128)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...64))
            }
            
            var deleteArray = insertArray
            deleteArray.shuffle()
            
            let realTree = BTree<Int>(order: Int.random(in: 3...16))
            let mockTree = MockMultiSearchTree<Int>()
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test1000MediumTreesDeleteAll()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test1000MediumTreesDeleteAll()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            if mockTree.count != 0 {
                XCTFail("Failed: test1000MediumTreesDeleteAll()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
            }
            
            if (loop % 100) == 0 {
                print("test1000MediumTreesDeleteAll() [\(loop) / 1000]")
            }
        }
    }
    
    func test100LargeTrees() {
        for loop in 0...100 {
            let insertCount = Int.random(in: 128...1024)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...256))
            }
            
            let deleteCount = Int.random(in: 128...1024)
            var deleteArray = [Int]()
            for _ in 0..<deleteCount {
                deleteArray.append(Int.random(in: 0...256))
            }
            
            let realTree = BTree<Int>(order: Int.random(in: 3...128))
            let mockTree = MockMultiSearchTree<Int>()
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test100LargeTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test100LargeTrees()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            if (loop % 10) == 0 {
                print("test100LargeTrees() [\(loop) / 100]")
            }
        }
    }
    
    func test100LargeTreesDeletingAll() {
        
        for loop in 0...100 {
            let insertCount = Int.random(in: 128...1024)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...256))
            }
            
            var deleteArray = insertArray
            deleteArray.shuffle()
            
            let realTree = BTree<Int>(order: Int.random(in: 3...128))
            let mockTree = MockMultiSearchTree<Int>()
            for value in insertArray {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test100LargeTreesDeletingAll()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            for value in deleteArray {
                realTree.remove(value)
                mockTree.remove(value)
            }
            
            if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                XCTFail("Failed: test100LargeTreesDeletingAll()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
                return
            }
            
            if mockTree.count != 0 {
                XCTFail("Failed: test100LargeTreesDeletingAll()")
                print("insert array: \(insertArray)")
                print("delete array: \(deleteArray)")
            }
            
            if (loop % 10) == 0 {
                print("test100LargeTreesDeletingAll() [\(loop) / 100]")
            }
        }
    }
}
