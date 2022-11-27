//
//  SplayTreeSimpleTests.swift
//  Tests
//
//  Created by Nick Raptis on 11/25/22.
//

import XCTest
@testable import TreeTests

final class SplayTreeSimpleTests: XCTestCase {

    func testInsertOneElement() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
    }
    
    func testInsertOneElementAndContains() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
    }
    
    func testInsertOneElementAndContainsDoesntContain() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(0) == false)
        XCTAssert(tree.contains(2) == false)
    }
    
    func testInsertThreeElements() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
    }
    
    func testInsertThreeElementsAndClear() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
        tree.clear()
        XCTAssert(tree.count == 0)
        XCTAssert(tree.root == nil)
    }
    
    func testInsertThreeElementsAndClearInsertThreeElementsAndClear() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
        tree.clear()
        XCTAssert(tree.count == 0)
        XCTAssert(tree.root == nil)
        tree.insert(4)
        tree.insert(5)
        tree.insert(6)
        XCTAssert(tree.count == 3)
        tree.clear()
        XCTAssert(tree.count == 0)
        XCTAssert(tree.root == nil)
    }
    
    func testInsertThreeElementsAndContains() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
    }
    
    func testInsertThreeElementsAndContainsDoesntContain() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        XCTAssert(tree.contains(-1) == false)
        XCTAssert(tree.contains(0) == false)
        XCTAssert(tree.contains(4) == false)
        XCTAssert(tree.contains(5) == false)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
    }
    
    func testInsertFiveElementsWithTwoDuplicates() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        XCTAssert(tree.count == 3)
    }
    
    func testInsertThreePopMin() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.popMin() == 1)
        XCTAssert(tree.popMin() == 2)
        XCTAssert(tree.popMin() == 3)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreePopMax() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        XCTAssert(tree.popMax() == 3)
        XCTAssert(tree.popMax() == 2)
        XCTAssert(tree.popMax() == 1)
        XCTAssert(tree.count == 0)
    }

    func testInsertThreeRemoveOneByOneVersion01() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion02() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion03() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion04() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion05() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion06() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(2)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion07() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion08() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion09() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion10() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion11() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion12() {
        let tree = SplayTree<Int>()
        tree.insert(1)
        tree.insert(3)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion13() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion14() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion15() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion16() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion17() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion18() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(1)
        tree.insert(3)
        
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion19() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion20() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion21() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion22() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion23() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion24() {
        let tree = SplayTree<Int>()
        tree.insert(2)
        tree.insert(3)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion25() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion26() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion27() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion28() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion29() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion30() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(1)
        tree.insert(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion31() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion32() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion33() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 3)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion34() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion35() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testInsertThreeRemoveOneByOneVersion36() {
        let tree = SplayTree<Int>()
        tree.insert(3)
        tree.insert(2)
        tree.insert(1)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.count == 3)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        
        tree.remove(3)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.count == 2)
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        
        tree.remove(2)
        
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.getMax() == 1)
        XCTAssert(tree.count == 1)
        XCTAssert(tree.contains(1))
        
        tree.remove(1)
        
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testKnownFailureCase1() {
        let input = [1, 2, 3, 0]
        let tree = SplayTree<Int>()
        for value in input {
            tree.insert(value)
            XCTAssert(tree.contains(value))
        }
        
        XCTAssert(tree.contains(0))
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(tree.contains(3))
        XCTAssert(tree.getMax() == 3)
        XCTAssert(tree.getMin() == 0)
        XCTAssert(tree.count == 4)
        
        tree.remove(3)
        
        XCTAssert(tree.contains(0))
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.getMin() == 0)
        XCTAssert(tree.count == 3)
        
        tree.remove(0)
        
        XCTAssert(!tree.contains(0))
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.count == 2)
        
        tree.remove(1)
        
        XCTAssert(!tree.contains(0))
        XCTAssert(!tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.count == 1)
        
        tree.remove(2)
        
        XCTAssert(!tree.contains(0))
        XCTAssert(!tree.contains(1))
        XCTAssert(!tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.count == 0)
    }
    
    func testKnownFailureCase2() {
        let input = [1, 2, 3, 0]
        let tree = SplayTree<Int>()
        for value in input {
            tree.insert(value)
        }
        
        tree.remove(3) // This causes an illegal tree.
        
        XCTAssert(tree.getMin() == 0)
        XCTAssert(tree.getMax() == 2) // This is the failure point.
        XCTAssert(tree.contains(0))
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.count == 3)
        
        tree.remove(0)
        
        XCTAssert(!tree.contains(0))
        XCTAssert(tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.getMin() == 1)
        XCTAssert(tree.count == 2)
        
        tree.remove(1)
        
        XCTAssert(!tree.contains(0))
        XCTAssert(!tree.contains(1))
        XCTAssert(tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == 2)
        XCTAssert(tree.getMin() == 2)
        XCTAssert(tree.count == 1)
        
        tree.remove(2)
        
        XCTAssert(!tree.contains(0))
        XCTAssert(!tree.contains(1))
        XCTAssert(!tree.contains(2))
        XCTAssert(!tree.contains(3))
        XCTAssert(tree.getMax() == nil)
        XCTAssert(tree.getMin() == nil)
        XCTAssert(tree.count == 0)
    }
    
}
