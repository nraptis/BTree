//
//  BTreeNodeSimpleTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/27/22.
//

import XCTest
@testable import TreeTests

final class BTreeNodeBoundsTests: XCTestCase {
    
    func addValue<Element>(node: BTreeNode<Element>, value: Element) {
        guard node.count < node.data.order else {
            XCTFail("BTreeNodeSimpleTests.addValue (\(value)) overflow")
            return
        }
        node.data.values[node.data.count] = value
        node.data.count += 1
    }
    
    func testLowerBound1() {
        let data = BTreeNodeData<Int>.createLeaf(order: 3)
        let node = BTreeNode(data: data)
        addValue(node: node, value: 0)
        if node.lowerBound(element: 0) != 0 {
            XCTFail("BTreeNodeSimpleTests.testLowerBound1 !node.lowerBound(element: 0) == 0")
        }
    }
    
    func testUpperBound1() {
        let data = BTreeNodeData<Int>.createLeaf(order: 3)
        let node = BTreeNode(data: data)
        addValue(node: node, value: 0)
        if node.upperBound(element: 0) != 1 {
            XCTFail("BTreeNodeSimpleTests.testLowerBound1 node.upperBound(element: 0) != 1")
        }
    }
    
    func testLowerBound_2_2_2_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...2 {
            for countMiddle in 0...2 {
                for countRightPadding in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_1 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_2_2_2_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...2 {
            for countRightPadding in 0...2 {
                for countMiddle in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_2 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_2_2_2_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...2 {
            for countLeftPadding in 0...2 {
                for countRightPadding in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_3 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_2_2_2_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...2 {
            for countRightPadding in 0...2 {
                for countLeftPadding in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_4 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_2_2_2_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...2 {
            for countLeftPadding in 0...2 {
                for countMiddle in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_5 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_2_2_2_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...2 {
            for countMiddle in 0...2 {
                for countLeftPadding in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_6 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_2_2_2_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_2_2_2_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...2 {
            for countMiddle in 0...2 {
                for countRightPadding in 0...2 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_1 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_2_2_2_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...2 {
            for countRightPadding in 0...2 {
                for countMiddle in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_2 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_2_2_2_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...2 {
            for countLeftPadding in 0...2 {
                for countRightPadding in 0...2 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_3 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_2_2_2_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...2 {
            for countRightPadding in 0...2 {
                for countLeftPadding in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_4 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_2_2_2_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...2 {
            for countLeftPadding in 0...2 {
                for countMiddle in 0...2 {
                
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_5 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_2_2_2_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...2 {
            for countMiddle in 0...2 {
                for countLeftPadding in 0...2 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_6 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_2_2_2_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    
    func testLowerBound_3_3_3_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...3 {
            for countMiddle in 0...3 {
                for countRightPadding in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_1 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_3_3_3_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...3 {
            for countRightPadding in 0...3 {
                for countMiddle in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_2 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_3_3_3_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...3 {
            for countLeftPadding in 0...3 {
                for countRightPadding in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_3 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_3_3_3_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...3 {
            for countRightPadding in 0...3 {
                for countLeftPadding in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_4 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_3_3_3_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...3 {
            for countLeftPadding in 0...3 {
                for countMiddle in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_5 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_3_3_3_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...3 {
            for countMiddle in 0...3 {
                for countLeftPadding in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_6 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_3_3_3_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_3_3_3_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...3 {
            for countMiddle in 0...3 {
                for countRightPadding in 0...3 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_1 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_3_3_3_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...3 {
            for countRightPadding in 0...3 {
                for countMiddle in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_2 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_3_3_3_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...3 {
            for countLeftPadding in 0...3 {
                for countRightPadding in 0...3 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_3 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_3_3_3_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...3 {
            for countRightPadding in 0...3 {
                for countLeftPadding in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_4 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_3_3_3_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...3 {
            for countLeftPadding in 0...3 {
                for countMiddle in 0...3 {
                
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_5 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_3_3_3_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...3 {
            for countMiddle in 0...3 {
                for countLeftPadding in 0...3 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_6 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_3_3_3_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_10_10_10_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...10 {
            for countMiddle in 0...10 {
                for countRightPadding in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_1 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_10_10_10_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...10 {
            for countRightPadding in 0...10 {
                for countMiddle in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_2 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_10_10_10_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...10 {
            for countLeftPadding in 0...10 {
                for countRightPadding in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_3 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_10_10_10_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...10 {
            for countRightPadding in 0...10 {
                for countLeftPadding in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_4 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_10_10_10_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...10 {
            for countLeftPadding in 0...10 {
                for countMiddle in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_5 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_10_10_10_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...10 {
            for countMiddle in 0...10 {
                for countLeftPadding in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_6 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_10_10_10_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_10_10_10_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...10 {
            for countMiddle in 0...10 {
                for countRightPadding in 0...10 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_1 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_10_10_10_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...10 {
            for countRightPadding in 0...10 {
                for countMiddle in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_2 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_10_10_10_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...10 {
            for countLeftPadding in 0...10 {
                for countRightPadding in 0...10 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_3 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_10_10_10_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...10 {
            for countRightPadding in 0...10 {
                for countLeftPadding in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_4 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_10_10_10_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...10 {
            for countLeftPadding in 0...10 {
                for countMiddle in 0...10 {
                
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_5 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_10_10_10_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...10 {
            for countMiddle in 0...10 {
                for countLeftPadding in 0...10 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_6 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_10_10_10_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testLowerBound_25_25_25_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...25 {
            for countMiddle in 0...25 {
                for countRightPadding in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_1 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_25_25_25_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...25 {
            for countRightPadding in 0...25 {
                for countMiddle in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_2 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_25_25_25_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...25 {
            for countLeftPadding in 0...25 {
                for countRightPadding in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_3 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_25_25_25_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...25 {
            for countRightPadding in 0...25 {
                for countLeftPadding in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_4 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_25_25_25_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...25 {
            for countLeftPadding in 0...25 {
                for countMiddle in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_5 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_25_25_25_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...25 {
            for countMiddle in 0...25 {
                for countLeftPadding in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.lowerBound(element: valueLeft) != 0 {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_6 node.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(node.lowerBound(element: valueLeft))")
                        return
                    }
                    if node.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(node.lowerBound(element: valueMiddle))")
                        return
                    }
                    if node.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testLowerBound_25_25_25_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_25_25_25_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...25 {
            for countMiddle in 0...25 {
                for countRightPadding in 0...25 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_1 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_1 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_1 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_25_25_25_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...25 {
            for countRightPadding in 0...25 {
                for countMiddle in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_2 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_2 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_2 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_25_25_25_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...25 {
            for countLeftPadding in 0...25 {
                for countRightPadding in 0...25 {
                    
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_3 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_3 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_3 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_25_25_25_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...25 {
            for countRightPadding in 0...25 {
                for countLeftPadding in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_4 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_4 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_4 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_25_25_25_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...25 {
            for countLeftPadding in 0...25 {
                for countMiddle in 0...25 {
                
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_5 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_5 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_5 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_25_25_25_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...25 {
            for countMiddle in 0...25 {
                for countLeftPadding in 0...25 {
                    let data = BTreeNodeData<Int>.createLeaf(order: countLeftPadding + countMiddle + countRightPadding)
                    let node = BTreeNode(data: data)
                    
                    for _ in 0..<countLeftPadding {
                        addValue(node: node, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(node: node, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(node: node, value: valueRight)
                    }
                    
                    if node.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_6 node.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(node.upperBound(element: valueLeft))")
                        return
                    }
                    if node.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_6 node.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(node.upperBound(element: valueMiddle))")
                        return
                    }
                    if node.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("BTreeNodeSimpleTests.testUpperBound_25_25_25_Config_6 node.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(node.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
}
