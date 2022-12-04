//
//  MockMultiSearchTreeSimpleTests.swift
//  Tests
//
//  Created by Nicky Taylor on 11/27/22.
//

import XCTest

final class MockMultiSearchTreeSimpleTests: XCTestCase {

    func testInsertOneElement() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
    }
    
    func testInsertThreeElements() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
    }
    
    func testInsertThreeElementsAndClear() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
        tree.clear()
        XCTAssert(tree.count == 0)
    }
    
    func testInsertFiveElementsWithTwoDuplicates() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        XCTAssert(tree.count == 5)
        XCTAssert(tree.countElement(1) == 2)
        XCTAssert(tree.countElement(2) == 2)
        XCTAssert(tree.countElement(3) == 1)
    }
    
    func testInsertThreePopMin() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.popMin() == 1)
        XCTAssert(tree.popMin() == 2)
        XCTAssert(tree.popMin() == 3)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreePopMax() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.popMax() == 3)
        XCTAssert(tree.popMax() == 2)
        XCTAssert(tree.popMax() == 1)
        XCTAssert(tree.count == 0)
    }
    
    func testRemoveFirstOne() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.countElement(1) == 1)
        tree.removeFirst(element: 1)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.countElement(1) == 0)
    }
    
    func testRemoveAllOne() {
        let tree = MockMultiSearchTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.countElement(1) == 1)
        tree.removeAll(element: 1)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.countElement(1) == 0)
    }
    
}
