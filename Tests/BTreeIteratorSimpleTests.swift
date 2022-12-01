//
//  BTreeIteratorSimpleTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/27/22.
//

import XCTest
@testable import TreeTests

final class BTreeIteratorSimpleTests: XCTestCase {

    func testIteratorZeroNodes() {
        
        let tree = BTree<Int>(order: 3)
        let iterator = BTreeIterator(node: tree.root, index: 0)
        if iterator.node != nil {
            XCTFail("BTreeIteratorSimpleTests.testIteratorZeroNodes() iterator not nil (I)")
            return
        }
        iterator.increment()
        if iterator.node != nil {
            XCTFail("BTreeIteratorSimpleTests.testIteratorZeroNodes() iterator not nil (II)")
            return
        }
        iterator.decrement()
        if iterator.node != nil {
            XCTFail("BTreeIteratorSimpleTests.testIteratorZeroNodes() iterator not nil (III)")
            return
        }
    }
    
    func createLeafNodeFromArray(order: Int, array: [Int]) -> BTreeNode<Int> {
        guard array.count <= order else {
            XCTFail("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
            fatalError("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
        }
        
        let data = BTreeNodeData<Int>.createLeaf(order: order, parent: nil)
        for (index, value) in array.enumerated() {
            data.values[index] = value
            data.count += 1
        }
        let result = BTreeNode<Int>(data: data)
        //result.parent = result
        return result
    }
    
    func createInternalNodeFromArray(order: Int, array: [Int]) -> BTreeNode<Int> {
        guard array.count <= order else {
            XCTFail("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
            fatalError("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
        }

        let data = BTreeNodeData<Int>.createInternal(order: order, parent: nil)
        for (index, value) in array.enumerated() {
            data.values[index] = value
            data.count += 1
        }
        let result = BTreeNode<Int>(data: data)
        //result.parent = result
        return result
    }
    
    func createRootLeafNodeFromArray(order: Int, array: [Int]) -> BTreeNode<Int> {
        guard array.count <= order else {
            XCTFail("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
            fatalError("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
        }

        let data = BTreeNodeData<Int>.createRootLeaf(order: order)
        for (index, value) in array.enumerated() {
            data.values[index] = value
            data.count += 1
        }
        let result = BTreeNode<Int>(data: data)
        result.parent = result
        return result
    }
    
    func createRootInternalNodeFromArray(order: Int, array: [Int]) -> BTreeNode<Int> {
        guard array.count <= order else {
            XCTFail("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
            fatalError("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
        }

        let data = BTreeNodeData<Int>.createRootInternal(order: order, parent: nil)
        for (index, value) in array.enumerated() {
            data.values[index] = value
            data.count += 1
        }
        let result = BTreeNode<Int>(data: data)
        result.isRoot = true
        result.parent = result
        return result
    }
    
    func testIteratorZeroValues() {
        let tree = BTree<Int>(order: 3)
        let iterator = tree.begin()
        let begin = tree.begin()
        let end = tree.end()
        if iterator != begin {
            XCTFail("BTreeIteratorSimpleTests.testIteratorZeroValues() iterator == begin")
            return
        }
        if iterator != end {
            XCTFail("BTreeIteratorSimpleTests.testIteratorZeroValues() iterator == end")
            return
        }
    }
    
    func testIteratorOneValueForward() {
        let node = createRootLeafNodeFromArray(order: 3, array: [10])
        let tree = BTree<Int>(order: 3)
        tree.setRoot(node)
        
        let iterator = tree.begin()
        let end = tree.end()
        
        if iterator == end {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueForward() iterator == end")
            return
        }
        
        if iterator.node == nil {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueForward() iterator.node is nil")
            return
        }
        
        if iterator.node?.value(index: iterator.index) != 10 {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueForward() iterator expected 10 at 0 ")
            return
        }
        
        iterator.increment()
        
        if iterator != end {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueForward() iterator != end")
            return
        }
    }
    
    func testIteratorOneValueBackward() {
        let node = createRootLeafNodeFromArray(order: 3, array: [10])
        let tree = BTree<Int>(order: 3)
        tree.setRoot(node)
        
        let iterator = tree.end()
        let begin = tree.begin()
        
        if iterator == begin {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueBackward() iterator == end")
            return
        }
        
        iterator.decrement()
        
        if iterator.node == nil {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueBackward() iterator.node is nil")
            return
        }
        
        if iterator.node?.value(index: iterator.index) != 10 {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueBackward() iterator expected 10 at 0")
            return
        }
        
        if iterator != begin {
            XCTFail("BTreeIteratorSimpleTests.testIteratorOneValueBackward() iterator != begin")
            return
        }
    }
    
    func testIteratorFiveValuesForward() {
        let order = 10
        let array = [1, 2, 3, 4, 5]
        let node = createRootLeafNodeFromArray(order: order, array: array)
        let tree = BTree<Int>(order: order)
        tree.setRoot(node)
        
        let iterator = tree.begin()
        let end = tree.end()
        var index = 0
        while iterator != end {
            if iterator.value() != array[index] {
                XCTFail("BTreeIteratorSimpleTests.testIteratorFiveValuesForward() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return
            }
            
            iterator.increment()
            index += 1
        }
        if index != array.count {
            XCTFail("BTreeIteratorSimpleTests.testIteratorFiveValuesForward() index (\(index)) != array.count (\(array.count))")
        }
    }
    
    func testIteratorFiveValuesBackward() {
        let order = 10
        let array = [1, 2, 3, 4, 5]
        let node = createRootLeafNodeFromArray(order: order, array: array)
        let tree = BTree<Int>(order: order)
        tree.setRoot(node)
        
        let iterator = tree.end()
        let begin = tree.begin()
        var index = array.count
        while iterator != begin {
            iterator.decrement()
            index -= 1
            
            if iterator.value() != array[index] {
                XCTFail("BTreeIteratorSimpleTests.testIteratorFiveValuesBackward() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return
            }
        }
        if index != 0 {
            XCTFail("BTreeIteratorSimpleTests.testIteratorFiveValuesBackward() index (\(index)) != 0")
        }
    }
    
    func checkForwardsIterator(tree: BTree<Int>, array: [Int]) -> Bool {
        guard tree.count == array.count else {
            XCTFail("BTreeIteratorSimpleTests.checkForwardsIterator() tree.count (\(tree.count)) != array.count (\(array.count))")
            return false
        }
        
        let iterator = tree.begin()
        let end = tree.end()
        var index = 0
        while iterator != end {
            if iterator.value() != array[index] {
                XCTFail("BTreeIteratorSimpleTests.checkForwardsIterator() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return false
            }
            
            iterator.increment()
            index += 1
        }
        if index != array.count {
            XCTFail("BTreeIteratorSimpleTests.checkForwardsIterator() index (\(index)) != array.count (\(array.count))")
            return false
        }
        
        return true
    }
    
    func checkBackwardsIterator(tree: BTree<Int>, array: [Int]) -> Bool {
        
        guard tree.count == array.count else {
            XCTFail("BTreeIteratorSimpleTests.checkBackwardsIterator() tree.count (\(tree.count)) != array.count (\(array.count))")
            return false
        }
        
        let iterator = tree.end()
        let begin = tree.begin()
        var index = array.count
        while iterator != begin {
            iterator.decrement()
            index -= 1
            
            if iterator.value() != array[index] {
                XCTFail("BTreeIteratorSimpleTests.checkBackwardsIterator() iterator.value() (\(iterator.value() ?? -1)) != array[index] (\(array[index]))")
                return false
            }
        }
        if index != 0 {
            XCTFail("BTreeIteratorSimpleTests.checkBackwardsIterator() index (\(index)) != 0")
            return false
        }
        
        return true
    }
    
    func testIteratorForwardAndBackward_10() {
        let order = 10
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let node = createRootLeafNodeFromArray(order: order, array: array)
        let tree = BTree<Int>(order: order)
        tree.setRoot(node)
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() backwards iterator array: \(array)")
            return
        }
    }
    
    func testIteratorForwardAndBackward_0_100() {
        var count = 0
        while count <= 1000 {
            var array = [Int]()
            for index in 0..<count {
                array.append(index)
            }
            let order = (count < 3) ? 3 : count
            let node = createRootLeafNodeFromArray(order: order, array: array)
            let tree = BTree<Int>(order: order)
            tree.setRoot(node)
            if !checkForwardsIterator(tree: tree, array: array) {
                XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() forwards iterator array: \(array)")
                return
            }
            if !checkBackwardsIterator(tree: tree, array: array) {
                XCTFail("BTreeIteratorSimpleTests.testIteratorForwardAndBackward_10() backwards iterator array: \(array)")
                return
            }
            count += 1
        }
    }
    
    func demoArray1() -> [Int] {
        [1, 2, 3]
    }
    
    func demoTree1() -> BTree<Int> {
        
        //    a1[2]
        //
        // b1[1] _ b2[3]
        
        let order = 3
        let result = BTree<Int>(order: order)
        let a1 = createRootInternalNodeFromArray(order: order, array: [2])
        let b1 = createLeafNodeFromArray(order: order, array: [1])
        let b2 = createLeafNodeFromArray(order: order, array: [3])
        a1.setChildren(array: [b1, b2])
        result.setRoot(a1)
        return result
    }
    
    func testDemoTree1() {
        
        let tree = demoTree1()
        let array = demoArray1()
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree1() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree1() backwards iterator array: \(array)")
            return
        }
    }
    
    func demoArray2() -> [Int] {
        [100, 101, 102, 103]
    }
    
    func demoTree2() -> BTree<Int> {
        
        //       a1[101]
        //
        // b1[100] _ b2[102, 103]
        
        let order = 3
        let result = BTree<Int>(order: order)
        let a1 = createRootInternalNodeFromArray(order: order, array: [101])
        let b1 = createLeafNodeFromArray(order: order, array: [100])
        let b2 = createLeafNodeFromArray(order: order, array: [102, 103])
        a1.setChildren(array: [b1, b2])
        result.setRoot(a1)
        return result
    }
    
    func testDemoTree2() {
        
        let tree = demoTree2()
        let array = demoArray2()
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree2() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree2() backwards iterator array: \(array)")
            return
        }
    }
    
    func demoArray3() -> [Int] {
        [50, 51, 52, 53, 54]
    }
    
    func demoTree3() -> BTree<Int> {
        
        //     a1[51,     53]
        //
        // b1[50] _ b2[52] _ b3[54]
        
        let order = 3
        let result = BTree<Int>(order: order)
        let a1 = createRootInternalNodeFromArray(order: order, array: [51, 53])
        let b1 = createLeafNodeFromArray(order: order, array: [50])
        let b2 = createLeafNodeFromArray(order: order, array: [52])
        let b3 = createLeafNodeFromArray(order: order, array: [54])
        a1.setChildren(array: [b1, b2, b3])
        result.setRoot(a1)
        return result
    }
    
    func testDemoTree3() {
        
        let tree = demoTree3()
        let array = demoArray3()
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree3() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree3() backwards iterator array: \(array)")
            return
        }
    }
    
    func demoArray4() -> [Int] {
        [74, 75, 76, 77, 78, 79]
    }
    
    func demoTree4() -> BTree<Int> {
        
        //     a1[75,     77]
        //
        // b1[74] _ b2[76] _ b3[78, 79]
        
        let order = 3
        let result = BTree<Int>(order: order)
        let a1 = createRootInternalNodeFromArray(order: order, array: [75, 77])
        let b1 = createLeafNodeFromArray(order: order, array: [74])
        let b2 = createLeafNodeFromArray(order: order, array: [76])
        let b3 = createLeafNodeFromArray(order: order, array: [78, 79])
        a1.setChildren(array: [b1, b2, b3])
        result.setRoot(a1)
        return result
    }
    
    func testDemoTree4() {
        
        let tree = demoTree4()
        let array = demoArray4()
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree3() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree3() backwards iterator array: \(array)")
            return
        }
    }
    
    func demoArray5() -> [Int] {
        [25, 26, 27, 28, 29, 30, 31]
    }
    
    func demoTree5() -> BTree<Int> {
        
        //              a1[28]
        //
        //     b1[26]             b2[30]
        //
        // c1[25] _ c2[27] __ c3[29] _ c4[31]
        
        let order = 3
        let result = BTree<Int>(order: order)
        let a1 = createRootInternalNodeFromArray(order: order, array: [28])
        
        let b1 = createInternalNodeFromArray(order: order, array: [26])
        let b2 = createInternalNodeFromArray(order: order, array: [30])
        
        let c1 = createLeafNodeFromArray(order: order, array: [25])
        let c2 = createLeafNodeFromArray(order: order, array: [27])
        let c3 = createLeafNodeFromArray(order: order, array: [29])
        let c4 = createLeafNodeFromArray(order: order, array: [31])
        
        b1.setChildren(array: [c1, c2])
        b2.setChildren(array: [c3, c4])
        a1.setChildren(array: [b1, b2])
        result.setRoot(a1)
        return result
    }
    
    func testDemoTree5() {
        
        let tree = demoTree5()
        let array = demoArray5()
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree5() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree5() backwards iterator array: \(array)")
            return
        }
    }
    
    func demoArray6() -> [Int] {
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    }
    
    func demoTree6() -> BTree<Int> {
        
        //         a1[03,         06           09           12]
        //
        // b1[01, 02] _ b2[04, 05] _ b3[07, 08] _ b4[10, 11] _ b5[13, 14]
        
        let order = 4
        let result = BTree<Int>(order: order)
        let a1 = createRootInternalNodeFromArray(order: order, array: [03, 06, 09, 12])
        
        let b1 = createLeafNodeFromArray(order: order, array: [01, 02])
        let b2 = createLeafNodeFromArray(order: order, array: [04, 05])
        let b3 = createLeafNodeFromArray(order: order, array: [07, 08])
        let b4 = createLeafNodeFromArray(order: order, array: [10, 11])
        let b5 = createLeafNodeFromArray(order: order, array: [13, 14])
        
        a1.setChildren(array: [b1, b2, b3, b4, b5])
        result.setRoot(a1)
        return result
    }
    
    func testDemoTree6() {
        
        let tree = demoTree6()
        let array = demoArray6()
        
        if !checkForwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree6() forwards iterator array: \(array)")
            return
        }
        if !checkBackwardsIterator(tree: tree, array: array) {
            XCTFail("BTreeIteratorSimpleTests.testDemoTree6() backwards iterator array: \(array)")
            return
        }
    }
}
