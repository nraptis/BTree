//
//  BTreeTestsRigorous.swift
//  BTreeTests
//
//  Created by Nicky Taylor on 12/4/22.
//

import XCTest
@testable import BTreeMac

final class BTreeTestsRigorous: XCTestCase {

    func test25000SmallTrees3Permutations() {
        for loop in 0...25000 {
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
            
            let insertPermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            let deletePermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            
            for insertPermutation in insertPermutations {
                for deletePermutation in deletePermutations {
                    let realTree = BTree<Int>(order: Int.random(in: 3...16))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test25000SmallTrees3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                    
                    for value in deletePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test25000SmallTrees3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                }
            }
            
            if (loop % 1000) == 0 {
                print("test25000SmallTrees3Permutations() [\(loop) / 25000]")
            }
        }
    }
    
    func test25000SmallTreesDeleteAll3Permutations() {
        
        for loop in 0...25000 {
            let insertCount = Int.random(in: 0...24)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...24))
            }
            
            let insertPermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            for insertPermutation in insertPermutations {
                for _ in insertPermutations {
                    var deleteArray = insertArray
                    deleteArray.shuffle()
                    
                    let realTree = BTree<Int>(order: Int.random(in: 3...16))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test25000SmallTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    for value in deleteArray {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test25000SmallTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    if mockTree.count != 0 {
                        XCTFail("Failed: test25000SmallTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                    }
                }
            }
            
            if (loop % 1000) == 0 {
                print("test25000SmallTreesDeleteAll3Permutations() [\(loop) / 25000]")
            }
        }
    }
    
    func test2000MediumTrees3Permutations() {
        for loop in 0...2000 {
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
            
            let insertPermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            let deletePermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            
            for insertPermutation in insertPermutations {
                for deletePermutation in deletePermutations {
                    let realTree = BTree<Int>(order: Int.random(in: 3...16))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test2000MediumTrees3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                    
                    for value in deletePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test2000MediumTrees3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                }
            }
            
            if (loop % 100) == 0 {
                print("test2000MediumTrees3Permutations() [\(loop) / 2000]")
            }
        }
    }
    
    func test2000MediumTreesDeleteAll3Permutations() {
        for loop in 0...2000 {
            let insertCount = Int.random(in: 0...128)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...64))
            }
            
            let insertPermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            for insertPermutation in insertPermutations {
                for _ in insertPermutations {
                    var deleteArray = insertArray
                    deleteArray.shuffle()
                    
                    let realTree = BTree<Int>(order: Int.random(in: 3...16))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test1000MediumTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    for value in deleteArray {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test1000MediumTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    if mockTree.count != 0 {
                        XCTFail("Failed: test1000MediumTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                    }
                }
            }
            
            if (loop % 100) == 0 {
                print("test10000SmallTreesDeleteAll3Permutations() [\(loop) / 2000]")
            }
        }
    }
    
    func test300LargeTrees3Permutations() {
        for loop in 0...300 {
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
            
            let insertPermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            let deletePermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            
            for insertPermutation in insertPermutations {
                for deletePermutation in deletePermutations {
                    let realTree = BTree<Int>(order: Int.random(in: 3...128))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test200LargeTrees3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                    
                    for value in deletePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test200LargeTrees3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                }
            }
            
            if (loop % 10) == 0 {
                print("test200LargeTrees3Permutations() [\(loop) / 300]")
            }
        }
    }
    
    func test300LargeTreesDeleteAll3Permutations() {
        for loop in 0...300 {
            let insertCount = Int.random(in: 128...1024)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...256))
            }
            
            let insertPermutations = insertArray.permutations(maxCount: 3, maxTries: 6)
            for insertPermutation in insertPermutations {
                for _ in insertPermutations {
                    var deleteArray = insertArray
                    deleteArray.shuffle()
                    
                    let realTree = BTree<Int>(order: Int.random(in: 3...128))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test200LargeTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    for value in deleteArray {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test200LargeTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    if mockTree.count != 0 {
                        XCTFail("Failed: test200LargeTreesDeleteAll3Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                    }
                }
            }
            
            if (loop % 10) == 0 {
                print("test200LargeTreesDeleteAll3Permutations() [\(loop) / 300]")
            }
        }
    }
    
}
