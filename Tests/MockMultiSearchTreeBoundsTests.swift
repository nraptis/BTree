//
//  MockMultiSearchTreeBoundsTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/27/22.
//

import XCTest
@testable import TreeTests

final class MockMultiSearchTreeBoundsTests: XCTestCase {

    func addValue<Element>(tree: MockMultiSearchTree<Element>, value: Element) {
        tree.insert(value)
    }
    
    func testLowerBound1() {
        let tree = MockMultiSearchTree<Int>()
        addValue(tree: tree, value: 0)
        if tree.lowerBound(element: 0) != 0 {
            XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound1 !tree.lowerBound(element: 0) == 0")
        }
    }
    
    func testUpperBound1() {
        let tree = MockMultiSearchTree<Int>()
        addValue(tree: tree, value: 0)
        if tree.upperBound(element: 0) != 1 {
            XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound1 tree.upperBound(element: 0) != 1")
        }
    }
    
    func testLowerBound_2_2_2_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...2 {
            for countMiddle in 0...2 {
                for countRightPadding in 0...2 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_1 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_2 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_3 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_4 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_5 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_6 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_2_2_2_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_2_2_2_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_4_4_4_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...4 {
            for countMiddle in 0...4 {
                for countRightPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_1 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_4_4_4_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...4 {
            for countRightPadding in 0...4 {
                for countMiddle in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_2 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_4_4_4_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...4 {
            for countLeftPadding in 0...4 {
                for countRightPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_3 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_4_4_4_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...4 {
            for countRightPadding in 0...4 {
                for countLeftPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_4 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_4_4_4_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...4 {
            for countLeftPadding in 0...4 {
                for countMiddle in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_5 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_4_4_4_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...4 {
            for countMiddle in 0...4 {
                for countLeftPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_6 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_4_4_4_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_4_4_4_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...4 {
            for countMiddle in 0...4 {
                for countRightPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_4_4_4_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...4 {
            for countRightPadding in 0...4 {
                for countMiddle in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_4_4_4_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...4 {
            for countLeftPadding in 0...4 {
                for countRightPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_4_4_4_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...4 {
            for countRightPadding in 0...4 {
                for countLeftPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_4_4_4_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...4 {
            for countLeftPadding in 0...4 {
                for countMiddle in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_4_4_4_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...4 {
            for countMiddle in 0...4 {
                for countLeftPadding in 0...4 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_4_4_4_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_5_5_5_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...5 {
            for countMiddle in 0...5 {
                for countRightPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_1 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_5_5_5_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...5 {
            for countRightPadding in 0...5 {
                for countMiddle in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_2 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_5_5_5_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...5 {
            for countLeftPadding in 0...5 {
                for countRightPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_3 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_5_5_5_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...5 {
            for countRightPadding in 0...5 {
                for countLeftPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_4 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_5_5_5_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...5 {
            for countLeftPadding in 0...5 {
                for countMiddle in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_5 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_5_5_5_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...5 {
            for countMiddle in 0...5 {
                for countLeftPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_6 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_5_5_5_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_5_5_5_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...5 {
            for countMiddle in 0...5 {
                for countRightPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_5_5_5_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...5 {
            for countRightPadding in 0...5 {
                for countMiddle in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_5_5_5_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...5 {
            for countLeftPadding in 0...5 {
                for countRightPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_5_5_5_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...5 {
            for countRightPadding in 0...5 {
                for countLeftPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_5_5_5_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...5 {
            for countLeftPadding in 0...5 {
                for countMiddle in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_5_5_5_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...5 {
            for countMiddle in 0...5 {
                for countLeftPadding in 0...5 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_5_5_5_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_6_6_6_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...6 {
            for countMiddle in 0...6 {
                for countRightPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_1 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_6_6_6_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...6 {
            for countRightPadding in 0...6 {
                for countMiddle in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_2 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_6_6_6_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...6 {
            for countLeftPadding in 0...6 {
                for countRightPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_3 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_6_6_6_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...6 {
            for countRightPadding in 0...6 {
                for countLeftPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_4 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_6_6_6_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...6 {
            for countLeftPadding in 0...6 {
                for countMiddle in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_5 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_6_6_6_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...6 {
            for countMiddle in 0...6 {
                for countLeftPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_6 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_6_6_6_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_6_6_6_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...6 {
            for countMiddle in 0...6 {
                for countRightPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_6_6_6_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...6 {
            for countRightPadding in 0...6 {
                for countMiddle in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_6_6_6_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...6 {
            for countLeftPadding in 0...6 {
                for countRightPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_6_6_6_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...6 {
            for countRightPadding in 0...6 {
                for countLeftPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_6_6_6_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...6 {
            for countLeftPadding in 0...6 {
                for countMiddle in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_6_6_6_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...6 {
            for countMiddle in 0...6 {
                for countLeftPadding in 0...6 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_6_6_6_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    
    func testLowerBound_7_7_7_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...7 {
            for countMiddle in 0...7 {
                for countRightPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_1 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_7_7_7_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...7 {
            for countRightPadding in 0...7 {
                for countMiddle in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_2 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_7_7_7_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...7 {
            for countLeftPadding in 0...7 {
                for countRightPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_3 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_7_7_7_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...7 {
            for countRightPadding in 0...7 {
                for countLeftPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_4 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_7_7_7_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...7 {
            for countLeftPadding in 0...7 {
                for countMiddle in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_5 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testLowerBound_7_7_7_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...7 {
            for countMiddle in 0...7 {
                for countLeftPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.lowerBound(element: valueLeft) != 0 {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_6 tree.lowerBound(element: valueLeft (\(valueLeft)) != 0, got value \(tree.lowerBound(element: valueLeft))")
                        return
                    }
                    if tree.lowerBound(element: valueMiddle) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != countLeftPadding (\(countLeftPadding)), got value \(tree.lowerBound(element: valueMiddle))")
                        return
                    }
                    if tree.lowerBound(element: valueRight) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testLowerBound_7_7_7_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_7_7_7_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...7 {
            for countMiddle in 0...7 {
                for countRightPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_7_7_7_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...7 {
            for countRightPadding in 0...7 {
                for countMiddle in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_7_7_7_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...7 {
            for countLeftPadding in 0...7 {
                for countRightPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_7_7_7_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...7 {
            for countRightPadding in 0...7 {
                for countLeftPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_7_7_7_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...7 {
            for countLeftPadding in 0...7 {
                for countMiddle in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_7_7_7_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...7 {
            for countMiddle in 0...7 {
                for countLeftPadding in 0...7 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_7_7_7_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_8_8_8_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...8 {
            for countMiddle in 0...8 {
                for countRightPadding in 0...8 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_8_8_8_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...8 {
            for countRightPadding in 0...8 {
                for countMiddle in 0...8 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_8_8_8_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...8 {
            for countLeftPadding in 0...8 {
                for countRightPadding in 0...8 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_8_8_8_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...8 {
            for countRightPadding in 0...8 {
                for countLeftPadding in 0...8 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_8_8_8_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...8 {
            for countLeftPadding in 0...8 {
                for countMiddle in 0...8 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_8_8_8_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...8 {
            for countMiddle in 0...8 {
                for countLeftPadding in 0...8 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_8_8_8_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
    
    func testUpperBound_9_9_9_Config_1() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...9 {
            for countMiddle in 0...9 {
                for countRightPadding in 0...9 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_9_9_9_Config_2() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countLeftPadding in 0...9 {
            for countRightPadding in 0...9 {
                for countMiddle in 0...9 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_9_9_9_Config_3() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...9 {
            for countLeftPadding in 0...9 {
                for countRightPadding in 0...9 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_9_9_9_Config_4() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countMiddle in 0...9 {
            for countRightPadding in 0...9 {
                for countLeftPadding in 0...9 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_9_9_9_Config_5() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...9 {
            for countLeftPadding in 0...9 {
                for countMiddle in 0...9 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }

    func testUpperBound_9_9_9_Config_6() {
        let valueLeft = -1
        let valueMiddle = 0
        let valueRight = 1
        for countRightPadding in 0...9 {
            for countMiddle in 0...9 {
                for countLeftPadding in 0...9 {
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_9_9_9_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_1 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_1 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_1 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_2 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_2 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_2 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_3 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_3 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_3 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_4 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_4 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_4 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_5 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_5 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_5 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
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
                    let tree = MockMultiSearchTree<Int>()
                    
                    for _ in 0..<countLeftPadding {
                        addValue(tree: tree, value: valueLeft)
                    }
                    for _ in 0..<countMiddle {
                        addValue(tree: tree, value: valueMiddle)
                    }
                    for _ in 0..<countRightPadding {
                        addValue(tree: tree, value: valueRight)
                    }
                    
                    if tree.upperBound(element: valueLeft) != countLeftPadding {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_6 tree.upperBound(element: valueLeft (\(valueLeft)) != countLeftPadding (\(countLeftPadding)), got value \(tree.upperBound(element: valueLeft))")
                        return
                    }
                    if tree.upperBound(element: valueMiddle) != (countLeftPadding + countMiddle) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_6 tree.lowerBound(element: valueMiddle (\(valueMiddle)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)), got value \(tree.upperBound(element: valueMiddle))")
                        return
                    }
                    if tree.upperBound(element: valueRight) != (countLeftPadding + countMiddle + countRightPadding) {
                        XCTFail("MockMultiSearchTreeBoundsTests.testUpperBound_10_10_10_Config_6 tree.lowerBound(element: valueRight (\(valueRight)) != (countLeftPadding (\(countLeftPadding)) + countMiddle (\(countMiddle)) + countRightPadding (\(countRightPadding))), got value \(tree.lowerBound(element: valueRight))")
                        return
                    }
                }
            }
        }
    }
}
