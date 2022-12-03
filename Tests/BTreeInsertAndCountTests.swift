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
    
    func test100RandomSmallArraysWithManyDupes50Permutations() {
        for _ in 0..<100 {
            var count1 = 0
            if Bool.random() { count1 = Int.random(in: 0...12) }
            
            var count2 = 0
            if Bool.random() { count2 = Int.random(in: 0...12) }
            
            var count3 = 0
            if Bool.random() { count3 = Int.random(in: 0...12) }
            
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
                    XCTFail("BTreeInsertAndCountTests.test100RandomSmallArraysWithManyDupes50Permutations() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func test100RandomLargerArraysWithManyDupes50Permutations() {
        for _ in 0..<100 {
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
            
            let permutations = array.permutations(maxCount: 50, maxTries: 75)
            for permutation in permutations {
                
                let realTree = BTree<Int>(order: 3)
                let mockTree = MockMultiSearchTree<Int>()
                for value in permutation {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.test100RandomLargerArraysWithManyDupes50Permutations() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func test20RandomLargerArraysWithManyDupes50PermutationsOrders3to10() {
        for order in 3...10 {
            for _ in 0..<20 {
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
                
                let permutations = array.permutations(maxCount: 50, maxTries: 75)
                for permutation in permutations {
                    
                    let realTree = BTree<Int>(order: order)
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in permutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    if !compareTrees(realTree: realTree, mockTree: mockTree) {
                        XCTFail("BTreeInsertAndCountTests.test100RandomLargerArraysWithManyDupes50Permutations() permutation: \(permutation)")
                        return
                    }
                }
            }
        }
    }
    
    func test20RandomHugeArraysWithManyDupes25Permutations() {
        
        for _ in 0..<20 {
            var count1 = 0
            if Bool.random() { count1 = Int.random(in: 0...300) }
            
            var count2 = 0
            if Bool.random() { count2 = Int.random(in: 0...300) }
            
            var count3 = 0
            if Bool.random() { count3 = Int.random(in: 0...300) }
            
            var array = [Int]()
            for _ in 0..<count1 { array.append(0) }
            for _ in 0..<count2 { array.append(1) }
            for _ in 0..<count3 { array.append(2) }
            
            let permutations = array.permutations(maxCount: 25, maxTries: 50)
            for permutation in permutations {
                
                let realTree = BTree<Int>(order: 3)
                let mockTree = MockMultiSearchTree<Int>()
                for value in permutation {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.test100RandomLargerArraysWithManyDupes50Permutations() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func test20RandomHugeArraysWithManyDupes10PermutationsOrders3to10() {
        for _ in 0..<20 {
            var count1 = 0
            if Bool.random() { count1 = Int.random(in: 0...300) }
            
            var count2 = 0
            if Bool.random() { count2 = Int.random(in: 0...300) }
            
            var count3 = 0
            if Bool.random() { count3 = Int.random(in: 0...300) }
            
            var array = [Int]()
            for _ in 0..<count1 { array.append(0) }
            for _ in 0..<count2 { array.append(1) }
            for _ in 0..<count3 { array.append(2) }
            
            let permutations = array.permutations(maxCount: 10, maxTries: 20)
            for permutation in permutations {
                
                let realTree = BTree<Int>(order: 3)
                let mockTree = MockMultiSearchTree<Int>()
                for value in permutation {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.test20RandomHugeArraysWithManyDupes10PermutationsOrders3to10() permutation: \(permutation)")
                    return
                }
            }
        }
    }
    
    func test1000LargeRandomArrays() {
        for loop in 0...1000 {
            if (loop % 100) == 0 {
                print("test1000LargeRandomArrays \(loop) / 1000")
            }
            
            let count = Int.random(in: 0...512)
            var array = [Int]()
            for _ in 0..<count {
                array.append(Int.random(in: 0...512))
            }
            
            let realTree = BTree<Int>(order: 3)
            let mockTree = MockMultiSearchTree<Int>()
            for value in array {
                realTree.insert(value)
                mockTree.insert(value)
            }
            if !compareTrees(realTree: realTree, mockTree: mockTree) {
                XCTFail("BTreeInsertAndCountTests.test1000LargeRandomArrays() array: \(array)")
                return
            }
        }
    }
    
    func test1000LargeRandomArraysOrder3to50() {
        for order in 3...50 {
            for loop in 0...1000 {
                if (loop % 100) == 0 {
                    print("test1000LargeRandomArraysOrder3to50 order \(order) / 50, loop \(loop) / 500")
                }
                
                let count = Int.random(in: 0...128)
                var array = [Int]()
                for _ in 0..<count {
                    array.append(Int.random(in: 0...128))
                }
                
                let realTree = BTree<Int>(order: order)
                let mockTree = MockMultiSearchTree<Int>()
                for value in array {
                    realTree.insert(value)
                    mockTree.insert(value)
                }
                if !compareTrees(realTree: realTree, mockTree: mockTree) {
                    XCTFail("BTreeInsertAndCountTests.test1000LargeRandomArraysOrder3to50() array: \(array)")
                    return
                }
            }
        }
    }
    
    func testExtremelyHardcore() {
        var testCount = 0
        for order in 3...100 {
            for loop in 0...1000 {
                if (loop % 100) == 0 {
                    print("testExtremelyHardcore order \(order) / 100, loop \(loop) / 1000 (\(testCount) tests!)")
                }
                var array = [Int]()
                if Bool.random() {
                    let count = Int.random(in: 0...256)
                    for _ in 0..<count {
                        array.append(Int.random(in: 0...256))
                    }
                }
                if Bool.random() {
                    var count1 = 0
                    if Bool.random() { count1 = Int.random(in: 0...128) }
                    var count2 = 0
                    if Bool.random() { count2 = Int.random(in: 0...128) }
                    var count3 = 0
                    if Bool.random() { count3 = Int.random(in: 0...128) }
                    for _ in 0..<count1 { array.append(0) }
                    for _ in 0..<count2 { array.append(1) }
                    for _ in 0..<count3 { array.append(2) }
                }
                if Bool.random() {
                    let count = Int.random(in: 0...128)
                    for _ in 0..<count {
                        array.append(Int.random(in: 0...128))
                    }
                }
                if Bool.random() {
                    var count1 = 0
                    if Bool.random() { count1 = Int.random(in: 0...128) }
                    var count2 = 0
                    if Bool.random() { count2 = Int.random(in: 0...128) }
                    var count3 = 0
                    if Bool.random() { count3 = Int.random(in: 0...128) }
                    for _ in 0..<count1 { array.append(0) }
                    for _ in 0..<count2 { array.append(1) }
                    for _ in 0..<count3 { array.append(2) }
                }
                if Bool.random() {
                    let count = Int.random(in: 0...128)
                    for _ in 0..<count {
                        array.append(Int.random(in: 0...128))
                    }
                }
                let permutations = array.permutations(maxCount: 10, maxTries: 15)
                for permutation in permutations {
                    let realTree = BTree<Int>(order: order)
                    let mockTree = MockMultiSearchTree<Int>()
                    for value in permutation {
                        realTree.insert(value)
                        mockTree.insert(value)
                    }
                    testCount += 1
                    if !compareTrees(realTree: realTree, mockTree: mockTree) {
                        XCTFail("BTreeInsertAndCountTests.testExtremelyHardcore() permutation: \(permutation)")
                        return
                    }
                }
            }
        }
    }
    
    func testKnownFailureCase01() {
        let order = 3
        let array = [2, 0, 2, 1, 2, 2, 1, 1, 0, 1]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()
        for value in array {
            realTree.insert(value)
            mockTree.insert(value)
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase01() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase02() {
        let order = 3
        let array = [2, 1, 1, 0, 2, 1, 2, 2, 2, 0, 0, 1, 2, 0, 0, 2, 1, 0]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()
        for value in array {
            realTree.insert(value)
            mockTree.insert(value)
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase02() array: \(array)")
            return
        }
        
        //                                    [2]
        //
        //        [0,        1,        2]               [2]
        //
        //[0, 0, 0] [0, 0, 1] [1, 1, 1] [2]       [2, 2]   [2]
        
        realTree.insert(0)
        mockTree.insert(0)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase02() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase03() {
        let order = 3
        let array = [0, 2, 2, 2, 1, 0, 1, 0, 2, 1, 2, 2, 2, 2, 2, 0, 1]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()
        for value in array {
            realTree.insert(value)
            mockTree.insert(value)
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase01() array: \(array)")
            return
        }
        
        //                 [1]
        //       [0]               [1,     2,        2]
        //  [0, 0] [0]           [1] [1, 2] [2, 2, 2] [2, 2, 2]
        
        realTree.insert(2)
        mockTree.insert(2)
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase01() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase04() {
        let order = 3
        let array = [2, 1, 1, 0, 0, 0, 1, 2, 2, 0, 1, 0, 2, 2, 0, 0, 1, 0]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()
        for value in array {
            realTree.insert(value)
            mockTree.insert(value)
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase04() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase05() {
        let order = 3
        let array = [2, 2, 1, 1, 0, 2, 1, 1, 0, 1, 2, 0, 1, 0, 2, 0, 2, 1, 0, 2, 0]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()
        
        for value in array {
            realTree.insert(value)
            mockTree.insert(value)
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase05() array: \(array)")
            return
        }
    }
    
    func testKnownFailureCase06() {
        let order = 4
        let array = [2, 2, 0, 0, 2, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2, 2, 0, 0, 0, 2, 2, 2, 2, 0, 2, 2, 0, 0, 2, 0, 0, 0, 2, 2, 2, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 0, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0]
        let realTree = BTree<Int>(order: order)
        let mockTree = MockMultiSearchTree<Int>()

        for value in array {
            realTree.insert(value)
            mockTree.insert(value)
        }
        
        if !compareTrees(realTree: realTree, mockTree: mockTree) {
            XCTFail("BTreeInsertAndCountTests.testKnownFailureCase06() array: \(array)")
            return
        }
    }
    
}
