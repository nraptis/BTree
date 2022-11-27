//
//  SplayTree.swift
//  TreeTests
//
//  Created by Nick Raptis on 11/23/22.
//

import Foundation

class SplayTree<Element: Comparable>: BinarySearchTreeConforming {
    
    final class SplayTreeNode<Element>: BinaryTreeNodeConforming {
        var value: Element
        var left: SplayTreeNode<Element>?
        var right: SplayTreeNode<Element>?
        init(value: Element) {
            self.value = value
        }
    }
    
    var root: SplayTreeNode<Element>?
    
    private(set) var count = 0
    
    func clear() {
        root = nil
        count = 0
    }
    
    func insert(_ element: Element) {
        if root == nil {
            root = BinaryTreeNode(value: element)
            count = 1
        }

        root = splay(root, element)
        guard let root = root else {
            return
        }

        if element < root.value {
            let node = BinaryTreeNode(value: element)
            node.left = root.left
            node.right = root
            root.left = nil
            self.root = node
            count += 1
        } else if element > root.value {
            let node = BinaryTreeNode(value: element)
            node.right = root.right
            node.left = root
            root.right = nil
            self.root = node
            count += 1
        } else {
            root.value = element
        }
    }
    
    func contains(_ element: Element) -> Bool {
        root = splay(root, element)
        guard let root = root else {
            return false
        }
        return root.value == element
    }
    
    func remove(_ element: Element) {
        if root == nil {
            return
        }
        
        root = splay(root, element)
        guard let originalRoot = root else {
            return
        }
        
        if originalRoot.value == element {
            if let left = originalRoot.left {
                let swap = originalRoot.right
                root = left
                count -= 1
                root = splay(root, element)
                root?.right = swap
                
            } else {
                root = originalRoot.right
                count -= 1
            }
        }
    }
    
    func getMin() -> Element? {
        guard var node = root else { return nil }
        while let left = node.left {
            node = left
        }
        return node.value
    }
    
    func popMin() -> Element? {
        if let element = getMin() {
            remove(element)
            return element
        } else {
            return nil
        }
    }
    
    func removeMin() {
        if let element = getMin() {
            remove(element)
        }
    }
    
    func getMax() -> Element? {
        guard var node = root else { return nil }
        while let right = node.right {
            node = right
        }
        return node.value
    }
    
    func popMax() -> Element? {
        if let element = getMax() {
            remove(element)
            return element
        } else {
            return nil
        }
    }
    
    func removeMax() {
        if let element = getMax() {
            remove(element)
        }
    }
    
    private func rotateRight(_ node: BinaryTreeNode) -> BinaryTreeNode {
        guard let swap = node.left else {
            return node
        }
        node.left = swap.right
        swap.right = node
        return swap
    }
    
    private func rotateLeft(_ node: BinaryTreeNode) -> BinaryTreeNode {
        guard let swap = node.right else {
            return node
        }
        node.right = swap.left
        swap.left = node
        return swap
    }
    
    private func splay(_ node: BinaryTreeNode?, _ element: Element) -> BinaryTreeNode? {
        guard var node = node else {
            return nil
        }
        if element < node.value {
            guard let left = node.left else {
                return node
            }
            if element < left.value {
                left.left = splay(left.left, element)
                node = rotateRight(node)
            } else if element > left.value {
                left.right = splay(left.right, element)
                if left.right != nil {
                    node.left = rotateLeft(left)
                }
            }
            if node.left == nil {
                return node
            } else {
                return rotateRight(node)
            }
        } else if element > node.value {
            guard let right = node.right else {
                return node
            }
            if element < right.value {
                right.left = splay(right.left, element)
                if right.left != nil {
                    node.right = rotateRight(right)
                }
            } else if element > right.value {
                right.right = splay(right.right, element)
                node = rotateLeft(node)
            }
            if node.right == nil {
                return node
            } else {
                return rotateLeft(node)
            }
        } else {
            return node
        }
    }
}
