//
//  BTree.swift
//
//  Created by Nick Raptis on 11/27/22.
//

import Foundation

struct BTreeIterator<Element: Comparable>: Equatable {
    
    static func == (lhs: BTreeIterator<Element>, rhs: BTreeIterator<Element>) -> Bool {
        (lhs.node === rhs.node) && (lhs.index == rhs.index)
    }
    
    var tree: BTree<Element>
    var node: BTreeNode<Element>?
    var index: Int
    
    init(tree: BTree<Element>, node: BTreeNode<Element>?, index: Int) {
        self.tree = tree
        self.node = node
        self.index = index
    }
    
    init(iterator: BTreeIterator<Element>) {
        self.tree = iterator.tree
        self.node = iterator.node
        self.index = iterator.index
    }
    
    mutating func set(iterator: BTreeIterator<Element>) {
        self.tree = iterator.tree
        self.node = iterator.node
        self.index = iterator.index
    }
    
    func value() -> Element? {
        return value(index: index)
    }
    
    func value(index: Int) -> Element? {
        if let node = node {
            return node.values[index]
        }
        return nil
    }
    
    mutating func increment() {
        if var node = node {
            if node.isLeaf {
                index += 1
                if index < node.count {
                    return
                }
            }
            
            if node.isLeaf {
                let holdNode = node
                let holdIndex = index
                while (index >= node.count) && (node !== tree.root), let parent = node.parent {
                    index = node.index
                    node = parent
                }
                if index >= node.count {
                    node = holdNode
                    index = holdIndex
                }
            } else {
                let child = node.children[index + 1]
                node = child
                while !node.isLeaf {
                    node = node.children[0]
                }
                index = 0
            }
            self.node = node
        }
    }
    
    mutating func decrement() {
        if var node = node {
            if node.isLeaf {
                index -= 1
                if index >= 0 {
                    return
                }
            }
            
            if node.isLeaf {
                let holdNode = node
                let holdIndex = index
                
                while (index < 0) && (node !== tree.root), let parent = node.parent {
                    index = node.index - 1
                    node = parent
                }
                if index < 0 {
                    node = holdNode
                    index = holdIndex
                }
            } else {
                let child = node.children[index]
                node = child
                while !node.isLeaf {
                    node = node.children[node.count]
                }
                index = node.count - 1
            }
            self.node = node
        }
    }
}
