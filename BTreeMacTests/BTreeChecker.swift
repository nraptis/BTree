//
//  BTreeChecker.swift
//  BTreeTests
//
//  Created by Nicky Taylor on 12/4/22.
//

import Foundation
import XCTest
@testable import BTreeMac

class BTreeChecker {
    
    static func compare(realTree: BTree<Int>, mockTree: MockMultiSearchTree<Int>) -> Bool {
        
        if realTree.count != mockTree.count {
            XCTFail("BTree.count (\(realTree.count)) != MockMultiSearchTree.count (\(mockTree.count))")
            return false
        }
        
        let minNumber = mockTree.getMin() ?? 0
        let maxNumber = mockTree.getMax() ?? 0
        
        for number in (minNumber - 1)...(maxNumber - 1) {
            
            if realTree.contains(number) != mockTree.contains(number) {
                XCTFail("BTree.contains(\(number)) (\(realTree.contains(number))) != MockMultiSearchTree.contains(\(number)) (\(mockTree.contains(number))")
                return false
            }
            if realTree.countElement(number) != mockTree.countElement(number) {
                XCTFail("BTree.countElement(\(number)) (\(realTree.countElement(number))) != MockSearchTree.countElement(\(number)) (\(mockTree.countElement(number))")
                return false
            }
        }
        
        let startIterator = realTree.startIterator()
        let endIterator = realTree.endIterator()
        
        var forwardIterator = realTree.startIterator()
        var index = 0
        while (forwardIterator != endIterator) && index < mockTree.count {
            guard let value = forwardIterator.value() else {
                XCTFail("BTree forwardIterator value nil at index \(index) / \(mockTree.count)")
                return false
            }
            guard value == mockTree.data[index] else {
                XCTFail("BTree forwardIterator.value() (\(value)) != mockTree.data[\(index)] (\(mockTree.data[index]))")
                return false
            }
            
            index += 1
            forwardIterator.increment()
        }
        
        guard forwardIterator == endIterator else {
            XCTFail("BTree forwardIterator did not end at endIterator")
            return false
        }
        
        guard index == mockTree.count else {
            XCTFail("BTree forwardIterator index (\(index)) did not end at mockTree.count (\(mockTree.count))")
            return false
        }
        
        index = mockTree.count
        var backwardIterator = realTree.endIterator()
        while (backwardIterator != startIterator) && index > 0 {
            backwardIterator.decrement()
            index -= 1
            
            guard let value = backwardIterator.value() else {
                XCTFail("BTree backwardIterator value nil at index \(index) / \(mockTree.count)")
                return false
            }
            guard value == mockTree.data[index] else {
                XCTFail("BTree backwardIterator.value() (\(value)) != mockTree.data[\(index)] (\(mockTree.data[index]))")
                return false
            }
        }
        guard backwardIterator == startIterator else {
            XCTFail("BTree backwardIterator did not end at endIterator")
            return false
        }
        guard index == 0 else {
            XCTFail("BTree backwardIterator index (\(index)) did not end at 0")
            return false
        }
        return true
    }
    
    
}
