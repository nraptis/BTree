//
//  MaxHeap.swift
//  HeapyHeaps
//
//  Created by Nick Raptis on 10/20/22.
//

import Foundation

struct MinHeap<Element: Comparable> {
    
    private(set) var data = [Element]()
    private(set) var count: Int = 0
    
    mutating func insert(_ element: Element?) {
        if let element = element {
            if count < data.count {
                data[count] = element
            } else {
                data.append(element)
            }
            var bubble = count
            var parent = (((bubble - 1)) >> 1)
            count += 1
            while bubble > 0 {
                if data[bubble] < data[parent] {
                    data.swapAt(bubble, parent)
                    bubble = parent
                    parent = (((bubble - 1)) >> 1)
                } else {
                    break
                }
            }
        }
    }
    
    func peek() -> Element? {
        if count > 0 { return data[0] }
        return nil
    }
    
    mutating func pop() -> Element? {
        if count > 0 {
            let result = data[0]
            count -= 1
            data[0] = data[count]
            var bubble = 0
            var leftChild = 1
            var rightChild = 2
            var minChild = 0
            while leftChild < count {
                minChild = leftChild
                if rightChild < count && data[rightChild] < data[leftChild] {
                    minChild = rightChild
                }
                if data[bubble] > data[minChild] {
                    data.swapAt(bubble, minChild)
                    bubble = minChild
                    leftChild = bubble * 2 + 1
                    rightChild = leftChild + 1
                } else {
                    break
                }
            }
            return result
            
        }
        return nil
    }
    
    func empty() -> Bool {
        return count == 0
    }
    
}

