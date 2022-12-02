//
//  AVLTreeCombinatoricTests.swift
//  Tests
//
//  Created by Nick Raptis on 11/22/22.
//

import XCTest
@testable import TreeTests

final class AVLTreeCombinatoricTests: XCTestCase {

    func compareTrees(realTree: AVLTree<Int>, mockTree: MockSearchTree<Int>) -> Bool {
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
            let value1 = realTree.select(index)
            let value2 = mockTree.select(index)
            if value1 != value2 {
                print("mock: \(mockTree.data)")
                XCTFail("Trees do not have equal index[\(index)]. AVL: \(value1 ?? -1), MOCK: \(value2 ?? -1)")
                return false
            }
            
            index += 1
        }
        
        index = 0
        while index < count {
            let value = mockTree.data[index]
            if !realTree.contains(value) {
                print("mock: \(mockTree.data)")
                XCTFail("Trees does not contain [\(index)]. AVL: MISSING, MOCK: \(value)")
                return false
            }
            index += 1
        }
        
        index = 0
        while index < count {
            let value = mockTree.data[index]
            if mockTree.index(value) != realTree.index(value) {
                print("mock: \(mockTree.data)")
                XCTFail("Trees does not contain [\(value)] at same index. AVL: \(mockTree.index(value) ?? -1), MOCK: \(realTree.index(value) ?? -1)")
                return false
            }
            index += 1
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
            let realTree = AVLTree<Int>()
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
    
    func testInsertWithCountClearing(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        
        let realTree = AVLTree<Int>()
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
                let realTree = AVLTree<Int>()
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
    
    
    func testInsertThenPopMinWithCount(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = AVLTree<Int>()
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
    
    func testInsertThenPopMaxWithCount(_ count: Int) {
        var array = [Int]()
        for index in 0..<count {
            array.append(index)
        }
        let permutations = array.allPermutations()
        for permutation in permutations {
            let realTree = AVLTree<Int>()
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
    
    
}
