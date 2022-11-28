//
//  BTreeNodeData.swift
//  TreeTests
//
//  Created by Nicky Taylor on 11/27/22.
//

import Foundation

class BTreeNodeData<Element: Comparable> {
    
    private init(order: Int, isLeaf: Bool, isRoot: Bool, parent: BTreeNode<Element>?) {
        self.order = order
        self.isLeaf = isLeaf
        self.isRoot = isRoot
        self.parent = parent
        self.values = [Element?](repeating: nil, count: order)
        if isLeaf {
            self.children = [BTreeNode<Element>?]()
        } else {
            self.children = [BTreeNode<Element>?](repeating: nil, count: order + 1)
        }
    }
    
    static func createLeaf(order: Int, parent: BTreeNode<Element>?) -> BTreeNodeData<Element> {
        BTreeNodeData(order: order, isLeaf: true, isRoot: false, parent: parent)
    }
    
    static func createInternal(order: Int, parent: BTreeNode<Element>?) -> BTreeNodeData<Element> {
        BTreeNodeData(order: order, isLeaf: false, isRoot: false, parent: parent)
    }
    
    static func createRoot(order: Int, parent: BTreeNode<Element>?) -> BTreeNodeData<Element> {
        BTreeNodeData(order: order, isLeaf: true, isRoot: true, parent: parent)
    }
    
    var order: Int
    var index: Int = 0
    var count: Int = 0
    var size: Int = 0
    var isLeaf: Bool
    var isRoot: Bool
    var parent: BTreeNode<Element>?
    var values: [Element?]
    var children: [BTreeNode<Element>?]
    
    weak var rightmost: BTreeNode<Element>?
    weak var leftmost: BTreeNode<Element>?
}
