//
//  BinaryTreeConforming.swift
//  TreeTests
//
//  Created by Nick Raptis on 11/21/22.
//

import Foundation

protocol BinaryTreeNodeConforming {
    associatedtype Element
    var left: Self? { get }
    var right: Self? { get }
    var value: Element { get }
}

protocol BinaryTreeConforming {
    associatedtype BinaryTreeNode: BinaryTreeNodeConforming
    var root: BinaryTreeNode? { get }
    var count: Int { get }
    func clear()
    func insert(_ element: BinaryTreeNode.Element)
}

protocol BinarySearchTreeConforming: BinaryTreeConforming where BinaryTreeNode.Element: Comparable {
    func contains(_ element: BinaryTreeNode.Element) -> Bool
    
    func remove(_ element: BinaryTreeNode.Element)
    
    func popMin() -> BinaryTreeNode.Element?
    func getMin() -> BinaryTreeNode.Element?
    func removeMin()
    
    func popMax() -> BinaryTreeNode.Element?
    func getMax() -> BinaryTreeNode.Element?
    func removeMax()
}

extension BinaryTreeConforming {
    func isEmpty() -> Bool {
        return root == nil
    }
    
    func maxDepth() -> Int {
        return maxDepth(root)
    }
    
    private func maxDepth(_ root: BinaryTreeNode?) -> Int {
        guard let root = root else { return 0 }
        let maxLeft = maxDepth(root.left)
        let maxRight = maxDepth(root.right)
        return max(maxLeft, maxRight) + 1
    }
}
