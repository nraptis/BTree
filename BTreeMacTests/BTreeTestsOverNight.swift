//
//  BTreeTestsOverNight.swift
//  BTreeTests
//
//  Created by Nicky Taylor on 12/4/22.
//

import XCTest
@testable import BTreeMac

final class BTreeTestsOverNight: XCTestCase {
    func test50000SmallTrees10Permutations() {
        for loop in 0...50000 {
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
            
            let insertPermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
            let deletePermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
            
            for insertPermutation in insertPermutations {
                for deletePermutation in deletePermutations {
                    let realTree = BTree<Int>(order: Int.random(in: 3...16))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test50000SmallTrees10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                    
                    for value in deletePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test50000SmallTrees10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                }
            }
            
            if (loop % 1000) == 0 {
                print("test50000SmallTrees10Permutations() [\(loop) / 50000]")
            }
        }
    }
    
    func test50000SmallTreesDeleteAll10Permutations() {
        
        for loop in 0...50000 {
            let insertCount = Int.random(in: 0...24)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...24))
            }
            
            let insertPermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
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
                        XCTFail("Failed: test50000SmallTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    for value in deleteArray {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test50000SmallTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    if mockTree.count != 0 {
                        XCTFail("Failed: test50000SmallTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                    }
                }
            }
            
            if (loop % 1000) == 0 {
                print("test50000SmallTreesDeleteAll10Permutations() [\(loop) / 50000]")
            }
        }
    }
    
    func test5000MediumTrees10Permutations() {
        for loop in 0...5000 {
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
            
            let insertPermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
            let deletePermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
            
            for insertPermutation in insertPermutations {
                for deletePermutation in deletePermutations {
                    let realTree = BTree<Int>(order: Int.random(in: 3...16))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test5000MediumTrees10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                    
                    for value in deletePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test5000MediumTrees10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                }
            }
            
            if (loop % 100) == 0 {
                print("test5000MediumTrees10Permutations() [\(loop) / 10000]")
            }
        }
    }
    
    func test5000MediumTreesDeleteAll10Permutations() {
        for loop in 0...5000 {
            let insertCount = Int.random(in: 0...128)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...64))
            }
            
            let insertPermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
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
                        XCTFail("Failed: test5000MediumTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    for value in deleteArray {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test5000MediumTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    if mockTree.count != 0 {
                        XCTFail("Failed: test5000MediumTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                    }
                }
            }
            
            if (loop % 100) == 0 {
                print("test5000MediumTreesDeleteAll10Permutations() [\(loop) / 5000]")
            }
        }
    }
    
    func test750LargeTrees10Permutations() {
        for loop in 0...750 {
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
            
            let insertPermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
            let deletePermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
            
            for insertPermutation in insertPermutations {
                for deletePermutation in deletePermutations {
                    let realTree = BTree<Int>(order: Int.random(in: 3...128))
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in insertPermutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test750LargeTrees10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                    
                    for value in deletePermutation {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test750LargeTrees10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deletePermutation)")
                        return
                    }
                }
            }
            
            if (loop % 10) == 0 {
                print("test750LargeTrees10Permutations() [\(loop) / 750]")
            }
        }
    }
    
    func test750LargeTreesDeleteAll10Permutations() {
        
        for loop in 0...750 {
            let insertCount = Int.random(in: 128...1024)
            var insertArray = [Int]()
            for _ in 0..<insertCount {
                insertArray.append(Int.random(in: 0...256))
            }
            
            let insertPermutations = insertArray.permutations(maxCount: 10, maxTries: 100)
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
                        XCTFail("Failed: test750LargeTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    for value in deleteArray {
                        realTree.remove(value)
                        mockTree.remove(value)
                    }
                    
                    if !BTreeChecker.compare(realTree: realTree, mockTree: mockTree) {
                        XCTFail("Failed: test750LargeTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                        return
                    }
                    
                    if mockTree.count != 0 {
                        XCTFail("Failed: test750LargeTreesDeleteAll10Permutations()")
                        print("insert array: \(insertPermutation)")
                        print("delete array: \(deleteArray)")
                    }
                }
            }
            
            if (loop % 10) == 0 {
                print("test750LargeTreesDeleteAll10Permutations() [\(loop) / 750]")
            }
        }
    }
}
