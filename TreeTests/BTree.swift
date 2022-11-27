//
//  BTree.swift
//  TreeTests
//
//  Created by Nicky Taylor on 11/25/22.
//

import Foundation

class BTree<Element: Comparable> {
    
    let order: Int
    private var root: BTreeNode<Element>? = nil
    private var height = 0
    private(set) var count = 0
    
    required init(order: Int) {
        self.order = order
    }
    
    func isEmpty() -> Bool {
        return root === nil
    }
    
    /*
     template <typename P> template <typename IterType>
     IterType btree<P>::internal_upper_bound(
     const key_type &key, IterType iter) const {
     if (iter.node) {
     for (;;) {
     iter.position = iter.node->upper_bound(key, key_comp());
     if (iter.node->leaf()) {
     break;
     }
     iter.node = iter.node->child(iter.position);
     }
     iter = internal_last(iter);
     }
     return iter;
     }
     */
    
    func delete_leaf_node(node: BTreeNode<Element>) {
        
    }
    
    func rebalance_or_split(iterator: BTreeIterator<Element>) {
        
    }
    
    func insert(_ element: Element) -> BTreeIterator<Element> {
        
        //if (empty()) {
        //  *mutable_root() = new_leaf_root_node(1);
        //}
        if isEmpty() {
            root = BTreeNode<Element>.createLeaf(order: order, parent: nil)
        }
        
        guard let root = root else {
            fatalError("BTree.insert(_ element: Element) root is null")
        }
        
        //iterator iter = internal_upper_bound(key, iterator(root(), 0));
        let rootIterator = BTreeIterator(node: root, index: 0)
        
        //TODO: upper bound...
        
        //if (!iter.node) {
        //    iter = end();
        //}
        
        //return internal_insert(iter, *value);
        return insert(iterator: rootIterator, element: element)
    }
    
    
    //need funcs:
    // tree::delete_leaf_node
    // tree::rebalance_or_split
    
    
    
    //btree<P>::internal_insert(iterator iter, const value_type &v) {
    @discardableResult
    private func insert(iterator: BTreeIterator<Element>, element: Element) -> BTreeIterator<Element> {
        
        guard let root = self.root else {
            fatalError("insert(iterator: BTreeIterator<Element>, element: Element) root is null")
        }
        
        //if (!iter.node->leaf()) {
        if !iterator.node.isLeaf {
            // We can't insert on an internal node. Instead, we'll insert after the
            // previous value which is guaranteed to be on a leaf node.
            //--iter;
            iterator.decrement()
            //++iter.position;
            iterator.index += 1
        }
        
        //if (iter.node->count() == iter.node->max_count()) {
        if iterator.node.count == iterator.node.order {
            
            // Make room in the leaf for the new item.
            //if (iter.node->max_count() < kNodeValues) {
            if iterator.node.order < order {
                // Insertion into the root where the root is smaller that the full node
                // size. Simply grow the size of the root node.
                
                //assert(iter.node == root());
                if iterator.node === root {
                    fatalError("BTree.insert(iterator: BTreeIterator<Element>, element: Element) iterator.node === root")
                }
                
                //iter.node = new_leaf_root_node(std::min<int>(kNodeValues, 2 * iter.node->max_count()));
                let newOrder = min(order, iterator.node.count * 2 + 1)
                iterator.node = BTreeNode<Element>.createLeaf(order: newOrder, parent: nil)
                
                //iter.node->swap(root());
                iterator.node.swap(node: root)
                
                //delete_leaf_node(root());
                delete_leaf_node(node: root)
                
                //*mutable_root() = iter.node;
                self.root = iterator.node
            } else {
                //rebalance_or_split(&iter);
                rebalance_or_split(iterator: iterator)
                
                //++*mutable_size();
                count += 1
            }
            //} else if (!root()->leaf()) {
        } else if !root.isLeaf {
            
            //++*mutable_size();
            count += 1
        }
        //iter.node->insert_value(iter.position, v);
        iterator.node.insert_value(index: iterator.index, element: element)
        
        //return iter;
        return iterator
    }
    
    
    /*
     template <typename P> template <typename ValuePointer>
     typename btree<P>::iterator
     btree<P>::insert_multi(const key_type &key, ValuePointer value) {
       
     }

     template <typename P>
     typename btree<P>::iterator
     btree<P>::insert_multi(iterator position, const value_type &v) {
       if (!empty()) {
         const key_type &key = params_type::key(v);
         if (position == end() || !compare_keys(position.key(), key)) {
           iterator prev = position;
           if (position == begin() || !compare_keys(key, (--prev).key())) {
             // prev.key() <= key <= position.key()
             return internal_insert(position, v);
           }
         } else {
           iterator next = position;
           ++next;
           if (next == end() || !compare_keys(next.key(), key)) {
             // position.key() < key <= next.key()
             return internal_insert(next, v);
           }
         }
       }
       return insert_multi(v);
     }

     template <typename P> template <typename InputIterator>
     void btree<P>::insert_multi(InputIterator b, InputIterator e) {
       for (; b != e; ++b) {
         insert_multi(end(), *b);
       }
     }

    */
    
    /*
    func internal_upper_bound(_ element: Element, iterator: BTreeIterator<Element>) -> BTreeIterator<Element> {
        //if (iter.node) {
        
        for (;;) {
            
            
            iter.position = iter.node->upper_bound(key, key_comp());
            
            if (iter.node->leaf()) {
                
                break;
                
            }
            
            iter.node = iter.node->child(iter.position);
            
        }
        
        iter = internal_last(iter);
        
    }
    
    return iter;
    */
}
