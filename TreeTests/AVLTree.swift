//
//  AVLTree.swift
//  TreeTests
//
//  Created by Nick Raptis on 11/21/22.
//

import Foundation

class AVLTree<Element: Comparable>: BinarySearchTreeConforming {
    
    var root: AVLTreeNode<Element>?
    
    final class AVLTreeNode<Element>: BinaryTreeNodeConforming {
        var value: Element
        var height: Int
        var count: Int
        var left: AVLTreeNode<Element>?
        var right: AVLTreeNode<Element>?
        init(value: Element, height: Int, count: Int) {
            self.value = value
            self.height = height
            self.count = count
        }
    }
    
    var count: Int {
        root?.count ?? 0
    }
    
    func clear() {
        root = nil
    }
    
    private func count(_ node: BinaryTreeNode?) -> Int {
        node?.count ?? 0
    }
    
    func height() -> Int {
        height(root)
    }
    
    private func height(_ node: BinaryTreeNode?) -> Int {
        node?.height ?? -1
    }
    
    func insert(_ element: Element) {
        root = insert(root, element)
    }
    
    private func insert(_ node: BinaryTreeNode?, _ element: Element) -> BinaryTreeNode {
        guard let node = node else {
            return BinaryTreeNode(value: element, height: 0, count: 1)
        }
        if element < node.value {
            node.left = insert(node.left, element)
        } else if element > node.value {
            node.right = insert(node.right, element)
        } else {
            node.value = element
            return node
        }
        node.count = 1 + count(node.left) + count(node.right)
        node.height = 1 + max(height(node.left), height(node.right))
        return balance(node)
    }
    
    func contains(_ element: BinaryTreeNode.Element) -> Bool {
        contains(element, root)
    }
    
    private func contains(_ element: BinaryTreeNode.Element, _ node: BinaryTreeNode?) -> Bool {
        guard let node = node else {
            return false
        }
        if element < node.value {
            return contains(element, node.left)
        } else if element > node.value {
            return contains(element, node.right)
        } else {
            return true
        }
    }
    
    func remove(_ element: Element) {
        if !contains(element) { return }
        root = remove(root, element)
    }
    
    private func remove(_ node: BinaryTreeNode?, _ element: Element) -> BinaryTreeNode? {
        guard var node = node else {
            return nil
        }
        if element < node.value {
            node.left = remove(node.left, element)
        } else if element > node.value {
            node.right = remove(node.right, element)
        } else {
            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            } else {
                let swap = node
                if let right = swap.right {
                    node = right
                    while let left = node.left {
                        node = left
                    }
                    node.right = removeMin(right)
                }
                node.left = swap.left
            }
        }
        node.count = 1 + count(node.left) + count(node.right)
        node.height = 1 + max(height(node.left), height(node.right))
        return balance(node)
    }
    
    func popMin() -> Element? {
        let result = getMin()
        removeMin()
        return result
    }
    
    func getMin() -> BinaryTreeNode.Element? {
        guard var node = root else { return nil }
        while let left = node.left {
            node = left
        }
        return node.value
    }
    
    private func getMinNode() -> BinaryTreeNode? {
        guard var node = root else { return nil }
        while let left = node.left {
            node = left
        }
        return node
    }
    
    private func getMinNode(_ node: BinaryTreeNode?) -> BinaryTreeNode? {
        guard var node = node else { return nil }
        while let left = node.left {
            node = left
        }
        return node
    }
    
    func removeMin() {
        guard let node = root else { return }
        root = removeMin(node)
    }
    
    func removeMin(_ node: BinaryTreeNode) -> BinaryTreeNode? {
        if let left = node.left {
            node.left = removeMin(left)
        } else {
            return node.right
        }
        node.count = 1 + count(node.left) + count(node.right)
        node.height = 1 + max(height(node.left), height(node.right))
        return balance(node)
    }
    
    func popMax() -> Element? {
        let result = getMax()
        removeMax()
        return result
    }
    
    func getMax() -> BinaryTreeNode.Element? {
        guard var node = root else { return nil }
        while let right = node.right {
            node = right
        }
        return node.value
    }
    
    private func getMaxNode() -> BinaryTreeNode? {
        guard var node = root else { return nil }
        while let right = node.right {
            node = right
        }
        return node
    }
    
    private func getMaxNode(_ node: BinaryTreeNode?) -> BinaryTreeNode? {
        guard var node = node else { return nil }
        while let right = node.right {
            node = right
        }
        return node
    }
    
    func removeMax() {
        guard let node = root else { return }
        root = removeMax(node)
    }
    
    func removeMax(_ node: BinaryTreeNode) -> BinaryTreeNode? {
        if let right = node.right {
            node.right = removeMax(right)
        } else {
            return node.left
        }
        node.count = 1 + count(node.left) + count(node.right)
        node.height = 1 + max(height(node.left), height(node.right))
        return balance(node)
    }
    
    func select(_ index: Int) -> Element? {
        if index < 0 { return nil }
        if index >= count { return nil }
        guard let node = root else { return nil }
        return select(node, index).value
    }
    
    func select(_ node: BinaryTreeNode, _ index: Int) -> BinaryTreeNode {
        let t = count(node.left)
        if let left = node.left, t > index {
            return select(left, index)
        } else if let right = node.right, t < index {
            return select(right, index - t - 1)
        } else {
            return node
        }
    }
    
    public func index(_ element: Element) -> Int? {
        return index(root, element)
    }
    
    public func index(_ node: BinaryTreeNode?, _ element: Element) -> Int? {
        guard let node = node else {
            return nil
        }
        if element < node.value {
            return index(node.left, element)
        } else if element > node.value {
            var result = 1 + count(node.left)
            if let indexFromRight = index(node.right, element) {
                result += indexFromRight
            }
            return result
        } else {
            return count(node.left)
        }
    }
    
    private func rotateRight(_ node: BinaryTreeNode) -> BinaryTreeNode {
        guard let swap = node.left else {
            return node
        }
        node.left = swap.right
        swap.right = node
        swap.count = node.count
        node.count = 1 + count(node.left) + count(node.right)
        node.height = 1 + max(height(node.left), height(node.right))
        swap.height = 1 + max(height(swap.left), height(swap.right))
        return swap
    }
    
    private func rotateLeft(_ node: BinaryTreeNode) -> BinaryTreeNode {
        guard let swap = node.right else {
            return node
        }
        node.right = swap.left
        swap.left = node
        swap.count = node.count
        node.count = 1 + count(node.left) + count(node.right)
        node.height = 1 + max(height(node.left), height(node.right))
        swap.height = 1 + max(height(swap.left), height(swap.right))
        return swap
    }
    
    private func balanceFactor(_ node: BinaryTreeNode) -> Int {
        return height(node.left) - height(node.right)
    }
    
    private func balance(_ node: BinaryTreeNode) -> BinaryTreeNode {
        var swap = node
        if balanceFactor(swap) < -1 {
            if let right = swap.right {
                if balanceFactor(right) > 0 {
                    swap.right = rotateRight(right)
                }
            }
            swap = rotateLeft(swap)
        } else if balanceFactor(swap) > 1 {
            if let left = swap.left {
                if balanceFactor(left) < 0 {
                    swap.left = rotateLeft(left)
                }
            }
            swap = rotateRight(swap)
        }
        return swap
    }
}
