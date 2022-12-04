//
//  BTree.swift
//
//  Created by Nick Raptis on 11/27/22.
//

import Foundation

class BTreeIterator<Element: Comparable>: Equatable {
    
    static func == (lhs: BTreeIterator<Element>, rhs: BTreeIterator<Element>) -> Bool {
        lhs.node === rhs.node && lhs.index == rhs.index
    }
    
    let tree: BTree<Element>
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
    
    func set(iterator: BTreeIterator<Element>) {
        self.node = iterator.node
        self.index = iterator.index
    }
    
    func value() -> Element? {
        return value(index: index)
    }
    
    func value(index: Int) -> Element? {
        if let node = node {
            if index >= 0 && index < node.count {
                if let result = node.data.values[index] {
                    return result
                }
            }
        }
        return nil
    }
    
    func increment() {
        if let node = node {
            if node.isLeaf {
                index += 1
                if index < node.count {
                    return
                }
            }
            incrementSlow()
        }
    }
    
    func incrementSlow() {
        if var node = node {
            if node.isLeaf {
                let holdNode = node
                let holdIndex = index
                while (index >= node.count) && (node != tree.root) {
                    if let parent = node.parent {
                        index = node.index
                        node = parent
                    }
                }
                
                if index >= node.count {
                    node = holdNode
                    index = holdIndex
                }
            } else {
                
                if let child = node.child(index: index + 1) {
                    node = child
                    while !node.isLeaf {
                        guard let innerChild = node.child(index: 0) else {
                            return
                        }
                        node = innerChild
                    }
                    index = 0
                }
            }
            self.node = node
        }
    }
    
    func decrement() {
        if let node = node {
            if node.isLeaf {
                index -= 1
                if index >= 0 {
                    return
                }
            }
            decrementSlow()
        }
    }
    
    func decrementSlow() {
        if var node = node {
            if node.isLeaf {
                let holdNode = node
                let holdIndex = index
                
                while (index < 0) && (node != tree.root) {
                    
                    if let parent = node.parent {
                        index = node.index - 1
                        node = parent
                    }
                }
                
                if index < 0 {
                    node = holdNode
                    index = holdIndex
                }
            } else {
                if let child = node.child(index: index) {
                    node = child
                    while !node.isLeaf {
                        if let child = node.child(index: node.count) {
                            node = child
                        }
                    }
                    index = node.count - 1
                }
            }
            self.node = node
        }
    }
}
