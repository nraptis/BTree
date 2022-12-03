//
//  BTreeNodeData.swift
//
//  Created by Nicky Taylor on 11/27/22.
//

import Foundation

class BTreeNodeData<Element: Comparable> {
    
    private init(order: Int, isLeaf: Bool) {
        self.order = order
        self.isLeaf = isLeaf
        self.values = [Element?](repeating: nil, count: order)
        if isLeaf {
            self.children = [BTreeNode<Element>?]()
        } else {
            self.children = [BTreeNode<Element>?](repeating: nil, count: order + 1)
        }
    }
    
    static func createLeaf(order: Int) -> BTreeNodeData<Element> {
        BTreeNodeData(order: order, isLeaf: true)
    }
    
    static func createInternal(order: Int) -> BTreeNodeData<Element> {
        BTreeNodeData(order: order, isLeaf: false)
    }
    
    var order: Int
    var index: Int = 0
    var count: Int = 0
    var size: Int = 0
    var isLeaf: Bool
    
    var parent: BTreeNode<Element>?
    var values: [Element?]
    var children: [BTreeNode<Element>?]
}
