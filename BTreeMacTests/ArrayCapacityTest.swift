//
//  ArrayCapacityTest.swift
//  BTreeMacTests
//
//  Created by Nicky Taylor on 12/4/22.
//

import XCTest

final class ArrayCapacityTest: XCTestCase {

    
    func testArrayCapacitySmall() {
        
        var array = [Int]()
        array.reserveCapacity(7)
        
        for i in 0..<5 {
            array.append(5)
            print("array: \(array), capacity: \(array.capacity), count: \(array.count)")
        }
        
        for i in 0..<5 {
            array.removeLast()
            print("array: \(array), capacity: \(array.capacity), count: \(array.count)")
        }
        
    }
    
}
