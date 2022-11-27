//
//  MockSearchTreeTests.swift
//  Tests
//
//  Created by Nick Raptis on 11/22/22.
//

import XCTest

final class MockSearchTreeSimpleTests: XCTestCase {

    func testInsertOneElement() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
    }
    
    func testInsertThreeElements() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
    }
    
    func testInsertThreeElementsAndClear() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
        tree.clear()
        XCTAssert(tree.count == 0)
    }
    
    func testInsertFiveElementsWithTwoDuplicates() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        XCTAssert(tree.count == 3)
    }
    
    func testInsertThreePopMin() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.popMin() == 1)
        XCTAssert(tree.popMin() == 2)
        XCTAssert(tree.popMin() == 3)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreePopMax() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.popMax() == 3)
        XCTAssert(tree.popMax() == 2)
        XCTAssert(tree.popMax() == 1)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion01() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion02() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion03() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion04() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion05() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion06() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    
    func testInsertThreeRemoveOneByOneVersion07() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion08() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion09() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion10() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion11() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion12() {
        let tree = MockSearchTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    
    func testInsertThreeRemoveOneByOneVersion13() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion14() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion15() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion16() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion17() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion18() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    
    func testInsertThreeRemoveOneByOneVersion19() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion20() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion21() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion22() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion23() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion24() {
        let tree = MockSearchTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion25() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion26() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion27() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion28() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion29() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion30() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion31() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion32() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 2)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion33() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion34() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion35() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
    
    func testInsertThreeRemoveOneByOneVersion36() {
        let tree = MockSearchTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        XCTAssert(tree.select(2) == 3)
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.select(0) == 1)
        XCTAssert(tree.select(1) == 2)
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.select(0) == 1)
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
        XCTAssert(tree.select(0) == nil)
    }
}
