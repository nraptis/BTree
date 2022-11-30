//
//  BTreeIterator.swift
//  TreeTests
//
//  Created by Nicky Taylor on 11/27/22.
//

import Foundation

class BTreeIterator<Element: Comparable>: Equatable {
    
    static func == (lhs: BTreeIterator<Element>, rhs: BTreeIterator<Element>) -> Bool {
        lhs.node === rhs.node && lhs.index == rhs.index
    }
    
    //private(set)
    var node: BTreeNode<Element>?
    
    //private(set)
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
    
        //if (node->leaf() && ++index < node->count()) {
        if let node = node {
            
            /*
            if node.count <= 0 {
                if let parent = node.parent, node.isRoot == false, node.index <= parent.count {
                    self.node = parent
                    self.index = node.index
                    return
                } else {
                    fatalError("BTreeIterator.increment() illegal node, node.count = \(node.count)")
                }
            }
            */
            
            if node.isLeaf {
                index += 1
                if index < node.count {
                    return
                }
            }
            incrementSlow()
        }
    }
    
    /*
    mutating func incrementBy(_ count: Int) {
        var count = count
        
        //while (count > 0) {
        while count > 0 {
            
            //if (node->leaf()) {
            if node.isLeaf {
                //int rest = node->count() - index;
                let rest = node.count - index
                
                //index += std::min(rest, count);
                index += min(rest, count)
                
                //count = count - rest;
                count -= rest
                
                //if (index < node->count()) {
                if index < node.count {
                
                    //return;
                    return
                }
            } else {
                //--count;
                count -= 1
            }
            
            //increment_slow();
            incrementSlow()
        }
    }
    */
    
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
                    
                    //position = node->position();
                    index = node.index
                    
                    //node = node->parent();
                    
                    node = parent
                }
                //if (position == node->count()) {
                if index >= node.count {
                
                    //*this = save;
                    //set(iterator: hold)
                    //node = hold.node
                    node = holdNode
                    index = holdIndex
                }
            } else {
                //assert(position < node->count());
                guard index < node.count else {
                    fatalError("BTreeIterator.incrementSlow index (\(index)) >= node.count (\(node.count))")
                }
                
                //node = node->child(position + 1);
                
                guard let child = node.child(index: index + 1) else {
                    fatalError("BTreeIterator.incrementSlow missing child index (\(index)) + 1")
                }
                
                node = child
                
                //while (!node->leaf()) {
                while !node.isLeaf {
                    //node = node->child(0);
                    
                    guard let child = node.child(index: 0) else {
                        fatalError("BTreeIterator.incrementSlow missing child index 0")
                    }
                    
                    node = child
                    
                }
                //position = 0;
                index = 0
            }
            self.node = node
                      
        }
    }
    
    //void decrement() {
    func decrement() {
        
        //if (node->leaf() && --position >= 0) {
        //  return;
        //}
        //decrement_slow();
        
        //if (node->leaf() && --index >= 0) {
        if let node = node {
            
            /*
            if node.count <= 0 {
                if let parent = node.parent, node.isRoot == false, node.index >= 0 {
                    self.node = parent
                    self.index = node.index
                    return
                } else {
                    fatalError("BTreeIterator.decrement() illegal node, node.count = \(node.count)")
                }
            }
            */
            
            if node.isLeaf {
                //return
                index -= 1
                if index >= 0 {
                    return
                }
            }
            //decrement_slow();
            decrementSlow()
        }
    }
    
    //void btree_iterator<N, R, P>::decrement_slow() {
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

////
// btree_iterator methods
/*
template <typename N, typename R, typename P>
void btree_iterator<N, R, P>::increment_slow() {
  if (node->leaf()) {
    assert(index >= node->count());
    self_type save(*this);
    while (index == node->count() && !node->is_root()) {
      assert(node->parent()->child(node->index()) == node);
      index = node->index();
      node = node->parent();
    }
    if (index == node->count()) {
      *this = save;
    }
  } else {
    assert(index < node->count());
    node = node->child(index + 1);
    while (!node->leaf()) {
      node = node->child(0);
    }
    index = 0;
  }
}

template <typename N, typename R, typename P>
void btree_iterator<N, R, P>::increment_by(int count) {
  while (count > 0) {
    if (node->leaf()) {
      int rest = node->count() - index;
      index += std::min(rest, count);
      count = count - rest;
      if (index < node->count()) {
        return;
      }
    } else {
      --count;
    }
    increment_slow();
  }
}

template <typename N, typename R, typename P>

*/

/*
template <typename Node, typename Reference, typename Pointer>
struct btree_iterator {
  typedef typename Node::key_type key_type;
  typedef typename Node::size_type size_type;
  typedef typename Node::difference_type difference_type;
  typedef typename Node::params_type params_type;

  typedef Node node_type;
  typedef typename std::remove_const<Node>::type normal_node;
  typedef const Node const_node;
  typedef typename params_type::value_type value_type;
  typedef typename params_type::pointer normal_pointer;
  typedef typename params_type::reference normal_reference;
  typedef typename params_type::const_pointer const_pointer;
  typedef typename params_type::const_reference const_reference;

  typedef Pointer pointer;
  typedef Reference reference;
  typedef std::bidirectional_iterator_tag iterator_category;

  typedef btree_iterator<
    normal_node, normal_reference, normal_pointer> iterator;
  typedef btree_iterator<
    const_node, const_reference, const_pointer> const_iterator;
  typedef btree_iterator<Node, Reference, Pointer> self_type;

  btree_iterator()
      : node(NULL),
        index(-1) {
  }
  btree_iterator(Node *n, int p)
      : node(n),
        index(p) {
  }
  btree_iterator(const iterator &x)
      : node(x.node),
        index(x.index) {
  }

  // Increment/decrement the iterator.
  void increment() {
    if (node->leaf() && ++index < node->count()) {
      return;
    }
    increment_slow();
  }
  void increment_by(int count);
  void increment_slow();

  void decrement() {
    if (node->leaf() && --index >= 0) {
      return;
    }
    decrement_slow();
  }
  void decrement_slow();

  bool operator==(const const_iterator &x) const {
    return node == x.node && index == x.index;
  }
  bool operator!=(const const_iterator &x) const {
    return node != x.node || index != x.index;
  }

  // Accessors for the key/value the iterator is pointing at.
  const key_type& key() const {
    return node->key(index);
  }
  reference operator*() const {
    return node->value(index);
  }
  pointer operator->() const {
    return &node->value(index);
  }

  self_type& operator++() {
    increment();
    return *this;
  }
  self_type& operator--() {
    decrement();
    return *this;
  }
  self_type operator++(int) {
    self_type tmp = *this;
    ++*this;
    return tmp;
  }
  self_type operator--(int) {
    self_type tmp = *this;
    --*this;
    return tmp;
  }

  // The node in the tree the iterator is pointing at.
  Node *node;
  // The index within the node of the tree the iterator is pointing at.
  int index;
};
*/
