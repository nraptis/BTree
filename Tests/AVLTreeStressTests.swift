//
//  AVLTreeStressTests.swift
//  Tests
//
//  Created by Nick Raptis on 11/22/22.
//

import XCTest
@testable import TreeTests

final class AVLTreeStressTests: XCTestCase {
    
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
    
    func testAdd1000ComparingEveryTime_5Times() {
        for _ in 0..<5 {
            var insert = [Int]()
            for _ in 0..<1000 { insert.append(Int.random(in: 0...1000)) }
            
            let realTree = AVLTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in insert {
                realTree.insert(value)
                mockTree.insert(value)
                
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    print("Failed insertion on {\(value)}: \(insert)")
                    return
                }
            }
        }
    }
    
    func testAdd1000Delete100ComparingEveryTime_5Times() {
        for _ in 0..<5 {
            var insert = [Int]()
            for _ in 0..<1000 { insert.append(Int.random(in: 0...1000)) }
            
            var remove = [Int]()
            for _ in 0..<1000 { remove.append(Int.random(in: 0...1000)) }
            
            let realTree = AVLTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in insert {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            for value in remove {
                realTree.remove(value)
                mockTree.remove(value)
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    print("Failed deletion on {\(value)}: \(insert)")
                    return
                }
            }
        }
    }
    
    func testAdd1000PopAllMins_10Times() {
        for _ in 0..<10 {
            var insert = [Int]()
            for _ in 0..<1000 { insert.append(Int.random(in: 0...1000)) }
            
            let realTree = AVLTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in insert {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            while mockTree.count > 0 {
                let min1 = realTree.popMin()
                let min2 = mockTree.popMin()
                if min1 != min2 {
                    XCTFail("Failed on popping mins... \(min1 ?? -1) vs \(min2 ?? -1)")
                    return
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    print("Failed on popping mins... \(insert) ... \(min1 ?? -1) vs \(min2 ?? -1)")
                    return
                }
            }
            
        }
    }
    
    func testAdd1000PopAllMaxes_10Times() {
        for _ in 0..<10 {
            var insert = [Int]()
            for _ in 0..<1000 { insert.append(Int.random(in: 0...1000)) }
            
            let realTree = AVLTree<Int>()
            let mockTree = MockSearchTree<Int>()
            
            for value in insert {
                realTree.insert(value)
                mockTree.insert(value)
            }
            
            while mockTree.count > 0 {
                let max1 = realTree.popMax()
                let max2 = mockTree.popMax()
                if max1 != max2 {
                    XCTFail("Failed on popping maxes... \(max1 ?? -1) vs \(max2 ?? -1)")
                    return
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    print("Failed on popping maxes... \(insert) ... \(max1 ?? -1) vs \(max2 ?? -1)")
                    return
                }
            }
            
        }
    }
    
    func arrayBig() -> [Int] {
        let count = Int.random(in: 0...100)
        var result = [Int](repeating: 0, count: count)
        for index in 0..<count {
            result[index] = Int.random(in: 0...100000)
        }
        return result
    }
    
    func arraySmall() -> [Int] {
        let count = Int.random(in: 0...25)
        var result = [Int](repeating: 0, count: count)
        for index in 0..<count {
            result[index] = Int.random(in: 0...100000)
        }
        return result
    }
    
    func testStress() {
        
        let realTree = AVLTree<Int>()
        let mockTree = MockSearchTree<Int>()
        
        for loop in 0...1000 {
        
            let operation = Int.random(in: 0...100)
            
            if operation < 50 {
                let input = Bool.random() ? arrayBig() : arraySmall()
                for value in input {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
            } else if operation < 75 {
                let delete = Bool.random() ? arrayBig() : arraySmall()
                for value in delete {
                    realTree.remove(value)
                    mockTree.remove(value)
                }
            } else if operation < 87 {
                let count = Int.random(in: 0...100)
                for _ in 0..<count {
                    let min1 = realTree.popMin()
                    let min2 = mockTree.popMin()
                    if min1 != min2 {
                        XCTFail("Failed on popping mins... \(min1 ?? -1) vs \(min2 ?? -1)")
                        return
                    }
                }
            } else if operation < 99 {
                let count = Int.random(in: 0...100)
                for _ in 0..<count {
                    let max1 = realTree.popMax()
                    let max2 = mockTree.popMax()
                    if max1 != max2 {
                        XCTFail("Failed on popping maxes... \(max1 ?? -1) vs \(max2 ?? -1)")
                        return
                    }
                }
            } else {
                if Int.random(in: 0...5) == 0 {
                    realTree.clear()
                    mockTree.clear()
                }
            }
            
            if (loop % 100) == 0 {
                print("Loop: \(loop) / 1000, count1: \(realTree.count), count2: \(mockTree.count)")
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                print("Failed stress test, operation: \(operation)")
                return
            }
        }
    }
}
