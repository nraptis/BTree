//
//  SplayTreeCombinatoricTests.swift
//  Tests
//
//  Created by Nick Raptis on 11/25/22.
//

import XCTest
@testable import TreeTests

final class SplayTreeCombinatoricTests: XCTestCase {

    func compareTrees(realTree: SplayTree<Int>, mockTree: MockSearchTree<Int>) -> Bool {
        if realTree.count != mockTree.count {
            XCTFail("Trees do not have equal count. AVL: \(realTree.count), MOCK: \(mockTree.count)")
            return false
        }
        
        if realTree.getMin() != mockTree.getMin() {
            XCTFail("Trees do not have equal min. AVL: \(realTree.getMin() ?? -1), MOCK: \(mockTree.getMin() ?? -1)")
            return false
        }
        
        if realTree.getMax() != mockTree.getMax() {
            XCTFail("Trees do not have equal max. AVL: \(realTree.getMax() ?? -1), MOCK: \(mockTree.getMax() ?? -1)")
            return false
        }
        
        let count = realTree.count
        var index = 0
        while index < count {
            let value = mockTree.data[index]
            if !realTree.contains(value) {
                print("mock: \(mockTree.data)")
                XCTFail("Trees does not contain [\(index)]. AVL: MISSING, MOCK: \(value)")
                return false
            }
            index += 1
        }
        return true
    }
    
    func compareTreesReverseOrder(realTree: SplayTree<Int>, mockTree: MockSearchTree<Int>) -> Bool {
        if realTree.count != mockTree.count {
            XCTFail("Trees do not have equal count. AVL: \(realTree.count), MOCK: \(mockTree.count)")
            return false
        }
        
        let count = realTree.count
        var index = 0
        while index < count {
            let value = mockTree.data[count - index - 1]
            if !realTree.contains(value) {
                print("mock: \(mockTree.data)")
                XCTFail("Trees does not contain [\(index)]. AVL: MISSING, MOCK: \(value)")
                return false
            }
            index += 1
        }
        
        if realTree.getMax() != mockTree.getMax() {
            XCTFail("Trees do not have equal max. AVL: \(realTree.getMax() ?? -1), MOCK: \(mockTree.getMax() ?? -1)")
            return false
        }
        
        if realTree.getMin() != mockTree.getMin() {
            XCTFail("Trees do not have equal min. AVL: \(realTree.getMin() ?? -1), MOCK: \(mockTree.getMin() ?? -1)")
            return false
        }
        
        return true
    }
    
    func compareTreesRandomOrder(realTree: SplayTree<Int>, mockTree: MockSearchTree<Int>) -> Bool {
        if realTree.count != mockTree.count {
            XCTFail("Trees do not have equal count. AVL: \(realTree.count), MOCK: \(mockTree.count)")
            return false
        }
        
        if realTree.getMax() != mockTree.getMax() {
            XCTFail("Trees do not have equal max. AVL: \(realTree.getMax() ?? -1), MOCK: \(mockTree.getMax() ?? -1)")
            return false
        }
        
        let count = realTree.count
        var index = 0
        
        let data = mockTree.data.shuffled()
        while index < count {
            let value = data[index]
            if !realTree.contains(value) {
                print("mock: \(mockTree.data)")
                XCTFail("Trees does not contain [\(index)]. AVL: MISSING, MOCK: \(value)")
                return false
            }
            index += 1
        }
        
        if realTree.getMin() != mockTree.getMin() {
            XCTFail("Trees do not have equal min. AVL: \(realTree.getMin() ?? -1), MOCK: \(mockTree.getMin() ?? -1)")
            return false
        }
        
        return true
    }
    
    func testInsertWithCount(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertWithCount0() { testInsertWithCount(0) }
    func testInsertWithCount1() { testInsertWithCount(1) }
    func testInsertWithCount2() { testInsertWithCount(2) }
    func testInsertWithCount3() { testInsertWithCount(3) }
    func testInsertWithCount4() { testInsertWithCount(4) }
    func testInsertWithCount5() { testInsertWithCount(5) }
    func testInsertWithCount6() { testInsertWithCount(6) }
    func testInsertWithCount7() { testInsertWithCount(7) }
    func testInsertWithCount8() { testInsertWithCount(8) }
    
    func testInsertWithCountReversed(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !compareTreesReverseOrder(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertWithCount0Reversed() { testInsertWithCountReversed(0) }
    func testInsertWithCount1Reversed() { testInsertWithCountReversed(1) }
    func testInsertWithCount2Reversed() { testInsertWithCountReversed(2) }
    func testInsertWithCount3Reversed() { testInsertWithCountReversed(3) }
    func testInsertWithCount4Reversed() { testInsertWithCountReversed(4) }
    func testInsertWithCount5Reversed() { testInsertWithCountReversed(5) }
    func testInsertWithCount6Reversed() { testInsertWithCountReversed(6) }
    func testInsertWithCount7Reversed() { testInsertWithCountReversed(7) }
    func testInsertWithCount8Reversed() { testInsertWithCountReversed(8) }
    
    func testInsertWithCountRandomized(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !compareTreesRandomOrder(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertWithCount0Randomized() { testInsertWithCountRandomized(0) }
    func testInsertWithCount1Randomized() { testInsertWithCountRandomized(1) }
    func testInsertWithCount2Randomized() { testInsertWithCountRandomized(2) }
    func testInsertWithCount3Randomized() { testInsertWithCountRandomized(3) }
    func testInsertWithCount4Randomized() { testInsertWithCountRandomized(4) }
    func testInsertWithCount5Randomized() { testInsertWithCountRandomized(5) }
    func testInsertWithCount6Randomized() { testInsertWithCountRandomized(6) }
    func testInsertWithCount7Randomized() { testInsertWithCountRandomized(7) }
    func testInsertWithCount8Randomized() { testInsertWithCountRandomized(8) }
    
    func testInsertWithCountClearing(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        
        let realTree = SplayTree<Int>()
        let mockTree = MockSearchTree<Int>()
        let permutations = array.allPermutations()
        for permutation in permutations {
            
            realTree.clear()
            mockTree.clear()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertWithCountClearing0() { testInsertWithCountClearing(0) }
    func testInsertWithCountClearing1() { testInsertWithCountClearing(1) }
    func testInsertWithCountClearing2() { testInsertWithCountClearing(2) }
    func testInsertWithCountClearing3() { testInsertWithCountClearing(3) }
    func testInsertWithCountClearing4() { testInsertWithCountClearing(4) }
    func testInsertWithCountClearing5() { testInsertWithCountClearing(5) }
    func testInsertWithCountClearing6() { testInsertWithCountClearing(6) }
    func testInsertWithCountClearing7() { testInsertWithCountClearing(7) }
    func testInsertWithCountClearing8() { testInsertWithCountClearing(8) }
    
    func testInsertThenRemoveAllWithCount(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for outer in permutations {
            for inner in permutations {
                let realTree = SplayTree<Int>()
                let mockTree = MockSearchTree<Int>()
                for value in outer {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                for value in inner {
                    realTree.remove(value)
                    mockTree.remove(value)
                    if !compareTrees(realTree: realTree, mockTree: mockTree) {
                        print("Failed on: \(outer), deleting: \(inner), value of \(value)")
                        return
                    }
                }
            }
        }
    }
    
    func testInsertThenRemoveAllWithCount0() { testInsertThenRemoveAllWithCount(0) }
    func testInsertThenRemoveAllWithCount1() { testInsertThenRemoveAllWithCount(1) }
    func testInsertThenRemoveAllWithCount2() { testInsertThenRemoveAllWithCount(2) }
    func testInsertThenRemoveAllWithCount3() { testInsertThenRemoveAllWithCount(3) }
    func testInsertThenRemoveAllWithCount4() { testInsertThenRemoveAllWithCount(4) }
    func testInsertThenRemoveAllWithCount5() { testInsertThenRemoveAllWithCount(5) }
    
    func testInsertThenRemoveAllWithCountReversed(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for outer in permutations {
            for inner in permutations {
                let realTree = SplayTree<Int>()
                let mockTree = MockSearchTree<Int>()
                for value in outer {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                for value in inner {
                    realTree.remove(value)
                    mockTree.remove(value)
                    if !compareTreesReverseOrder(realTree: realTree, mockTree: mockTree) {
                        print("Failed on: \(outer), deleting: \(inner), value of \(value)")
                        return
                    }
                }
            }
        }
    }
    
    func testInsertThenRemoveAllWithCount0Reversed() { testInsertThenRemoveAllWithCountReversed(0) }
    func testInsertThenRemoveAllWithCount1Reversed() { testInsertThenRemoveAllWithCountReversed(1) }
    func testInsertThenRemoveAllWithCount2Reversed() { testInsertThenRemoveAllWithCountReversed(2) }
    func testInsertThenRemoveAllWithCount3Reversed() { testInsertThenRemoveAllWithCountReversed(3) }
    func testInsertThenRemoveAllWithCount4Reversed() { testInsertThenRemoveAllWithCountReversed(4) }
    func testInsertThenRemoveAllWithCount5Reversed() { testInsertThenRemoveAllWithCountReversed(5) }
    
    func testInsertThenRemoveAllWithCountRandomized(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for outer in permutations {
            for inner in permutations {
                let realTree = SplayTree<Int>()
                let mockTree = MockSearchTree<Int>()
                for value in outer {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                for value in inner {
                    realTree.remove(value)
                    mockTree.remove(value)
                    if !compareTreesRandomOrder(realTree: realTree, mockTree: mockTree) {
                        print("Failed on: \(outer), deleting: \(inner), value of \(value)")
                        return
                    }
                }
            }
        }
    }
    
    func testInsertThenRemoveAllWithCount0Randomized() { testInsertThenRemoveAllWithCountRandomized(0) }
    func testInsertThenRemoveAllWithCount1Randomized() { testInsertThenRemoveAllWithCountRandomized(1) }
    func testInsertThenRemoveAllWithCount2Randomized() { testInsertThenRemoveAllWithCountRandomized(2) }
    func testInsertThenRemoveAllWithCount3Randomized() { testInsertThenRemoveAllWithCountRandomized(3) }
    func testInsertThenRemoveAllWithCount4Randomized() { testInsertThenRemoveAllWithCountRandomized(4) }
    func testInsertThenRemoveAllWithCount5Randomized() { testInsertThenRemoveAllWithCountRandomized(5) }
    
    func testInsertThenPopMinWithCount(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
            
            while realTree.count > 0 {
                let min1 = realTree.popMin()
                let min2 = mockTree.popMin()
                
                if min1 != min2 {
                    XCTFail("Mins are not equal!")
                    print("Failed on: \(permutation), popping min real: \(min1 ?? -1) mock: \(min2 ?? -1)")
                    return
                    
                }
                
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    print("Failed on: \(permutation), popping min, count: \(mockTree.count)")
                    return
                }
            }
            if realTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
            if mockTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertThenPopMinWithCount0() { testInsertThenPopMinWithCount(0) }
    func testInsertThenPopMinWithCount1() { testInsertThenPopMinWithCount(1) }
    func testInsertThenPopMinWithCount2() { testInsertThenPopMinWithCount(2) }
    func testInsertThenPopMinWithCount3() { testInsertThenPopMinWithCount(3) }
    func testInsertThenPopMinWithCount4() { testInsertThenPopMinWithCount(4) }
    func testInsertThenPopMinWithCount5() { testInsertThenPopMinWithCount(5) }
    func testInsertThenPopMinWithCount6() { testInsertThenPopMinWithCount(6) }
    func testInsertThenPopMinWithCount7() { testInsertThenPopMinWithCount(7) }
    func testInsertThenPopMinWithCount8() { testInsertThenPopMinWithCount(8) }
    
    func testInsertThenPopMinWithCountReversed(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTreesReverseOrder(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
            
            while realTree.count > 0 {
                let min1 = realTree.popMin()
                let min2 = mockTree.popMin()
                
                if min1 != min2 {
                    XCTFail("Mins are not equal!")
                    print("Failed on: \(permutation), popping min real: \(min1 ?? -1) mock: \(min2 ?? -1)")
                    return
                    
                }
                
                if !compareTreesReverseOrder(realTree: realTree, mockTree: mockTree) {
                    print("Failed on: \(permutation), popping min, count: \(mockTree.count)")
                    return
                }
            }
            if realTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
            if mockTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertThenPopMinWithCount0Reversed() { testInsertThenPopMinWithCountReversed(0) }
    func testInsertThenPopMinWithCount1Reversed() { testInsertThenPopMinWithCountReversed(1) }
    func testInsertThenPopMinWithCount2Reversed() { testInsertThenPopMinWithCountReversed(2) }
    func testInsertThenPopMinWithCount3Reversed() { testInsertThenPopMinWithCountReversed(3) }
    func testInsertThenPopMinWithCount4Reversed() { testInsertThenPopMinWithCountReversed(4) }
    func testInsertThenPopMinWithCount5Reversed() { testInsertThenPopMinWithCountReversed(5) }
    func testInsertThenPopMinWithCount6Reversed() { testInsertThenPopMinWithCountReversed(6) }
    func testInsertThenPopMinWithCount7Reversed() { testInsertThenPopMinWithCountReversed(7) }
    func testInsertThenPopMinWithCount8Reversed() { testInsertThenPopMinWithCountReversed(8) }
    
    func testInsertThenPopMinWithCountRandomized(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTreesRandomOrder(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
            
            while realTree.count > 0 {
                let min1 = realTree.popMin()
                let min2 = mockTree.popMin()
                
                if min1 != min2 {
                    XCTFail("Mins are not equal!")
                    print("Failed on: \(permutation), popping min real: \(min1 ?? -1) mock: \(min2 ?? -1)")
                    return
                    
                }
                
                if !compareTreesRandomOrder(realTree: realTree, mockTree: mockTree) {
                    print("Failed on: \(permutation), popping min, count: \(mockTree.count)")
                    return
                }
            }
            if realTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
            if mockTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertThenPopMinWithCount0Randomized() { testInsertThenPopMinWithCountRandomized(0) }
    func testInsertThenPopMinWithCount1Randomized() { testInsertThenPopMinWithCountRandomized(1) }
    func testInsertThenPopMinWithCount2Randomized() { testInsertThenPopMinWithCountRandomized(2) }
    func testInsertThenPopMinWithCount3Randomized() { testInsertThenPopMinWithCountRandomized(3) }
    func testInsertThenPopMinWithCount4Randomized() { testInsertThenPopMinWithCountRandomized(4) }
    func testInsertThenPopMinWithCount5Randomized() { testInsertThenPopMinWithCountRandomized(5) }
    func testInsertThenPopMinWithCount6Randomized() { testInsertThenPopMinWithCountRandomized(6) }
    func testInsertThenPopMinWithCount7Randomized() { testInsertThenPopMinWithCountRandomized(7) }
    func testInsertThenPopMinWithCount8Randomized() { testInsertThenPopMinWithCountRandomized(8) }
    
    func testInsertThenPopMaxWithCount(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
            
            while realTree.count > 0 {
                let min1 = realTree.popMax()
                let min2 = mockTree.popMax()
                
                if min1 != min2 {
                    XCTFail("Mins are not equal!")
                    print("Failed on: \(permutation), popping min real: \(min1 ?? -1) mock: \(min2 ?? -1)")
                    return
                }
                
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    print("Failed on: \(permutation), popping min, count: \(mockTree.count)")
                    return
                }
            }
            if realTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
            if mockTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertThenPopMaxWithCount0() { testInsertThenPopMaxWithCount(0) }
    func testInsertThenPopMaxWithCount1() { testInsertThenPopMaxWithCount(1) }
    func testInsertThenPopMaxWithCount2() { testInsertThenPopMaxWithCount(2) }
    func testInsertThenPopMaxWithCount3() { testInsertThenPopMaxWithCount(3) }
    func testInsertThenPopMaxWithCount4() { testInsertThenPopMaxWithCount(4) }
    func testInsertThenPopMaxWithCount5() { testInsertThenPopMaxWithCount(5) }
    func testInsertThenPopMaxWithCount6() { testInsertThenPopMaxWithCount(6) }
    func testInsertThenPopMaxWithCount7() { testInsertThenPopMaxWithCount(7) }
    func testInsertThenPopMaxWithCount8() { testInsertThenPopMaxWithCount(8) }
    
    func testInsertThenPopMaxWithCountReversed(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTreesReverseOrder(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
            
            while realTree.count > 0 {
                let min1 = realTree.popMax()
                let min2 = mockTree.popMax()
                
                if min1 != min2 {
                    XCTFail("Mins are not equal!")
                    print("Failed on: \(permutation), popping min real: \(min1 ?? -1) mock: \(min2 ?? -1)")
                    return
                }
                
                if !compareTreesReverseOrder(realTree: realTree, mockTree: mockTree) {
                    print("Failed on: \(permutation), popping min, count: \(mockTree.count)")
                    return
                }
            }
            if realTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
            if mockTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertThenPopMaxWithCount0Reversed() { testInsertThenPopMaxWithCountReversed(0) }
    func testInsertThenPopMaxWithCount1Reversed() { testInsertThenPopMaxWithCountReversed(1) }
    func testInsertThenPopMaxWithCount2Reversed() { testInsertThenPopMaxWithCountReversed(2) }
    func testInsertThenPopMaxWithCount3Reversed() { testInsertThenPopMaxWithCountReversed(3) }
    func testInsertThenPopMaxWithCount4Reversed() { testInsertThenPopMaxWithCountReversed(4) }
    func testInsertThenPopMaxWithCount5Reversed() { testInsertThenPopMaxWithCountReversed(5) }
    func testInsertThenPopMaxWithCount6Reversed() { testInsertThenPopMaxWithCountReversed(6) }
    func testInsertThenPopMaxWithCount7Reversed() { testInsertThenPopMaxWithCountReversed(7) }
    func testInsertThenPopMaxWithCount8Reversed() { testInsertThenPopMaxWithCountReversed(8) }
    
    func testInsertThenPopMaxWithCountRandomized(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = SplayTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in permutation {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTreesRandomOrder(realTree: realTree, mockTree: mockTree) {
                print("Failed on: \(permutation)")
                return
            }
            
            while realTree.count > 0 {
                let min1 = realTree.popMax()
                let min2 = mockTree.popMax()
                
                if min1 != min2 {
                    XCTFail("Mins are not equal!")
                    print("Failed on: \(permutation), popping min real: \(min1 ?? -1) mock: \(min2 ?? -1)")
                    return
                }
                
                if !compareTreesRandomOrder(realTree: realTree, mockTree: mockTree) {
                    print("Failed on: \(permutation), popping min, count: \(mockTree.count)")
                    return
                }
            }
            if realTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
            if mockTree.count != 0 {
                XCTFail("Tree should be empty!")
                print("Failed on: \(permutation)")
                return
            }
        }
    }
    
    func testInsertThenPopMaxWithCount0Randomized() { testInsertThenPopMaxWithCountRandomized(0) }
    func testInsertThenPopMaxWithCount1Randomized() { testInsertThenPopMaxWithCountRandomized(1) }
    func testInsertThenPopMaxWithCount2Randomized() { testInsertThenPopMaxWithCountRandomized(2) }
    func testInsertThenPopMaxWithCount3Randomized() { testInsertThenPopMaxWithCountRandomized(3) }
    func testInsertThenPopMaxWithCount4Randomized() { testInsertThenPopMaxWithCountRandomized(4) }
    func testInsertThenPopMaxWithCount5Randomized() { testInsertThenPopMaxWithCountRandomized(5) }
    func testInsertThenPopMaxWithCount6Randomized() { testInsertThenPopMaxWithCountRandomized(6) }
    func testInsertThenPopMaxWithCount7Randomized() { testInsertThenPopMaxWithCountRandomized(7) }
    func testInsertThenPopMaxWithCount8Randomized() { testInsertThenPopMaxWithCountRandomized(8) }
}
