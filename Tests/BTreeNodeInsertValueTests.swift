//
//  BTreeNodeInsertValueTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/27/22.
//

import XCTest
@testable import TreeTests

final class BTreeNodeInsertValueTests: XCTestCase {
    
    func insertValue(node: BTreeNode<Int>, index: Int, value: Int) {
        guard node.count < node.data.order else {
            XCTFail("BTreeNodeInsertValueTests.insertValue count: \(node.count) index: \(index) value: (\(value)) order overflow")
            return
        }
        guard index < node.data.order else {
            XCTFail("BTreeNodeInsertValueTests.insertValue index: \(index) value: (\(value)) index overflow")
            return
        }
        guard index >= 0 else {
            XCTFail("BTreeNodeInsertValueTests.insertValue index: \(index) value: (\(value)) index underflow")
            return
        }
        node.data.values[node.data.count] = value
        node.data.count += 1
    }
    
    func equal(node: BTreeNode<Int>, array: [Int]) -> Bool {
        if node.data.values.count < array.count {
            XCTFail("BTreeNodeInsertValueTests.equal(node: BTreeNode<Int>, array: [Int]) node.data.values: \(node.data.values) array: \(array) array overflow")
            return false
        }
        
        if node.count != array.count {
            XCTFail("BTreeNodeInsertValueTests.equal(node: BTreeNode<Int>, array: [Int]) node.data.values: \(node.data.values) array: \(array) counts not equal array: \(array.count) node: \(node.count)")
            return false
        }
        
        for index in 0..<array.count {
            if node.data.values[index] != array[index] {
                XCTFail("BTreeNodeInsertValueTests.equal(node: BTreeNode<Int>, array: [Int]) node.data.values: \(node.data.values) array: \(array) array overflow")
                XCTFail("BTreeNodeInsertValueTests.equal(node: BTreeNode<Int>, array: [Int]) array[\(index)] (\(array[index])) != data[\(index)] (\(node.data.values[index] ?? Int.min))")
                return false
            }
        }
        
        return true
    }
    
    func createSequentialNode(order: Int, count: Int) -> BTreeNode<Int> {
        var array = [Int]()
        var index = 0
        while index < count {
            array.append(index)
            index += 1
        }
        return createNodeFromArray(order: order, array: array)
    }
    
    func createNodeFromArray(order: Int, array: [Int]) -> BTreeNode<Int> {
        guard array.count <= order else {
            XCTFail("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
            fatalError("BTreeNodeSimpleTests.createNodeFromArray array.count: (\(array.count)) order: \(order) count overflow")
        }

        let data = BTreeNodeData<Int>.createInternal(order: order, parent: nil)
        for (index, value) in array.enumerated() {
            data.values[index] = value
            data.count += 1
        }
        return BTreeNode<Int>(data: data)
    }
    
    func testInsertOneAtZeroFromZero() {
        let data = BTreeNodeData<Int>.createLeaf(order: 1, parent: nil)
        let node = BTreeNode(data: data)
        insertValue(node: node, index: 0, value: 0)
        if node.count != 1 {
            XCTFail("BTreeNodeInsertValueTests.testInsertOneAtZero node.count (\(node.count)) != 1")
            return
        }
        if node.value(index: 0) != 0 {
            XCTFail("BTreeNodeInsertValueTests.testInsertOneAtZero node.value(index: 0) (\(node.value(index: 0) ?? Int.min)) != 0")
            return
        }
    }
    
    func testCreateSimpleSequenceOne() {
        let node = createSequentialNode(order: 1, count: 1)
        if node.count != 1 {
            XCTFail("BTreeNodeInsertValueTests.testInsertOneAtZero node.count (\(node.count)) != 1")
            return
        }
        
        if !equal(node: node, array: [0]) {
            XCTFail("BTreeNodeInsertValueTests.testInsertOneAtZero node.value(index: 0) (\(node.data.values)) != [0]")
            return
        }
    }
    
    func testCreateSimpleSequenceThree() {
        let node = createSequentialNode(order: 3, count: 3)
        if node.count != 3 {
            XCTFail("BTreeNodeInsertValueTests.testInsertOneAtZero node.count (\(node.count)) != 1")
            return
        }
        
        if !equal(node: node, array: [0, 1, 2]) {
            XCTFail("BTreeNodeInsertValueTests.testInsertOneAtZero node.value(index: 0) (\(node.data.values)) != [0, 1, 2]")
            return
        }
    }
    
    func testCreateSimpleSequencesWithOneInsert100TimesAnd10OrdersAnd10Inserts() {
        let insertValue = 999
        for iteration in 0...100 {
            for order in 1...10 {
                for insert in 0...order {
                    for count in 0...order {
                        
                        var array = [Int](repeating: 0, count: count)
                        for index in 0..<count { array[index] = index }
                        let node = createSequentialNode(order: order, count: count)
                        
                        if !equal(node: node, array: array) {
                            XCTFail("BTreeNodeInsertValueTests.testCreateSimpleSequencesWithOneInsert100TimesAnd10OrdersAnd10Inserts iteration: \(iteration) order: \(order) insert: \(insert) count: \(count)")
                            XCTFail("BTreeNodeInsertValueTests.testCreateSimpleSequencesWithOneInsert100TimesAnd10OrdersAnd10Inserts array: \(array), node.data.values: \(node.data.values)")
                            return
                        }
                        
                        if order > 0 && count < order && insert <= count {
                            node.insert_value(index: insert, element: insertValue)
                            array.insert(insertValue, at: insert)
                        }
                        
                        if !equal(node: node, array: array) {
                            XCTFail("BTreeNodeInsertValueTests.testCreateSimpleSequencesWithOneInsert100TimesAnd10OrdersAnd10Inserts iteration: \(iteration) order: \(order) insert: \(insert) count: \(count)")
                            XCTFail("BTreeNodeInsertValueTests.testCreateSimpleSequencesWithOneInsert100TimesAnd10OrdersAnd10Inserts array: \(array), node.data.values: \(node.data.values)")
                            return
                        }
                        
                    }
                }
            }
        }
    }
}
