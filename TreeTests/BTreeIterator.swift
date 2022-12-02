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
    
    var node: BTreeNode<Element>?
    var index: Int
    
    init(node: BTreeNode<Element>?, index: Int) {
        self.node = node
        self.index = index
    }
    
    init(iterator: BTreeIterator<Element>) {
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
            //if (node->leaf()) {
            
            //if (node->leaf()) {
            if node.isLeaf {
                //assert(position >= node->count());
                guard index >= node.count else {
                    fatalError("BTreeIterator.incrementSlow index (\(index)) >= node.count (\(node.count))")
                }
                
                //self_type save(*this);
                //let hold = BTreeIterator<Element>(iterator: self)
                let holdNode = node
                let holdIndex = index
                
                //while (position == node->count() && !node->is_root()) {
                while (index >= node.count) && !node.isRoot {
                
                    guard let parent = node.parent else {
                        fatalError("BTreeIterator.incrementSlow node.parent is null")
                    }
                    
                    //assert(node->parent()->child(node->position()) == node);
                    guard parent.child(index: node.index) === node else {
                        fatalError("BTreeIterator.incrementSlow node.parent.child(index: node.index (\(node.index))) !== node")
                    }
                    
                    index = node.index
                    node = parent
                }
                
                if index >= node.count {
                    node = holdNode
                    index = holdIndex
                }
            } else {
                
                guard index < node.count else {
                    fatalError("BTreeIterator.incrementSlow index (\(index)) >= node.count (\(node.count))")
                }
                
                guard let child = node.child(index: index + 1) else {
                    fatalError("BTreeIterator.incrementSlow missing child index (\(index)) + 1")
                }
                
                node = child
                while !node.isLeaf {
                    guard let child = node.child(index: 0) else {
                        fatalError("BTreeIterator.incrementSlow missing child index 0")
                    }
                    node = child
                }
                index = 0
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
        
        //if (node->leaf()) {
        if var node = node {
            if node.isLeaf {
                
                //assert(index <= -1);
                //if index <= -1 {
                guard index <= -1 else {
                    fatalError("BTreeIterator.decrementSlow index (\(index)) >= 0")
                }
                
                //self_type save(*this);
                //let hold = BTreeIterator<Element>(iterator: self)
                let holdNode = node
                let holdIndex = index
                
                //while (index < 0 && !node->is_root()) {
                while (index < 0) && !node.isRoot {
                    
                    guard let parent = node.parent else {
                        fatalError("BTreeIterator.incrementSlow node.parent is null")
                    }
                    
                    //assert(node->parent()->child(node->index()) == node);
                    guard parent.child(index: node.index) === node else {
                        fatalError("BTreeIterator.decrementSlow node.parent.child(index: node.index (\(node.index))) !== node")
                    }
                    
                    //index = node->index() - 1;
                    index = node.index - 1
                    
                    //node = node->parent();
                    node = parent
                }
                
                //if (index < 0) {
                if index < 0 {
                    //*this = save;
                    //self = hold
                    //set(iterator: hold)
                    node = holdNode
                    index = holdIndex
                }
            } else {
                
                //assert(index >= 0);
                guard index >= 0 else {
                    fatalError("BTreeIterator.decrementSlow index (\(index)) < 0")
                }
                
                
                //node = node->child(index);
                
                guard let child = node.child(index: index) else {
                    fatalError("BTreeIterator.decrementSlow missing child index (\(index))")
                }
                node = child
                
                //while (!node->leaf()) {
                while !node.isLeaf {
                    
                    guard let child = node.child(index: node.count) else {
                        fatalError("BTreeIterator.decrementSlow missing child node.count (\(node.count))")
                    }
                    
                    //node = node->child(node->count());
                    node = child
                }
                
                //index = node->count() - 1;
                index = node.count - 1
            }
            self.node = node
        }
        
    }
}
