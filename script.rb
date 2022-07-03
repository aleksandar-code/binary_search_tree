# frozen_string_literal: true
require 'pry-byebug'
# Node class
class Node
  def initialize(value = nil, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end
  attr_accessor :value, :left_child, :right_child
end

# Tree class
# build_tree method algorithm:
# 1: Initialize start = 0, end = length of the array – 1
# 2: mid = (start+end)/2
# 3: Create a tree node with mid as root (lets call it A).
# 4: Recursively do following steps:
# 5: Calculate mid of left subarray and make it root of left subtree of A.
# 6: Calculate mid of right subarray and make it root of right subtree of A
class Tree
  def initialize(array = [])
    @array = array
    @root = nil
  end

  def root(root)
    @root = root
  end

  def build_tree(array = [], start_arr = 0, end_arr = 0, count = 0)
    return nil if start_arr > end_arr 
    array = @array.uniq.sort if count == 0
    count += 1
    start_arr = 0
    end_arr = array.length - 1
    mid_arr = (start_arr + end_arr) / 2
    root = Node.new(array[mid_arr])
    root.left_child = build_tree(array[start_arr.. mid_arr-1], start_arr, mid_arr-1, count)
    root.right_child = build_tree(array[mid_arr+1.. end_arr], mid_arr+1, end_arr, count)
    root(root)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
# insert method 
# i want to take the root and do a depth first search compare current_root and value
# if current_root > value then value compare to the left child
  def insert(value, root = nil, inserted = false)
    # binding.pry
    root = @root if root == nil 
    return nil if inserted
    inserted = false
    if root.value > value
      if root.left_child == nil
        root.left_child = Node.new(value)
        inserted = true
      end
      root = root.left_child
    else
      if root.right_child == nil
        root.right_child = Node.new(value)
        inserted = true
      end
      root = root.right_child
    end
    insert(value, root, inserted)
  end
# There are 3 cases 
# 1. We delete a leaf in the tree
# 2. the node has 1 child 
# 3. the node has 2 child
  def delete(value, root = nil, deleted = false, not_found = false)
    root = @root if root == nil 
    return nil if deleted || not_found || @root.value == value
    deleted = false
    if root.value > value 
      if root.left_child.value == value
        root.left_child = nil if leaf(root.left_child)
        root.left_child = root.left_child.left_child if single_child(root.right_child) && root.left_child.left_child != nil
        root.left_child = root.left_child.right_child if single_child(root.right_child) && root.left_child.right_child != nil
        deleted = true
      else 
        root = root.left_child
      end
    else 
      if root.right_child.value == value 
        root.right_child = nil if leaf(root.right_child)
        root.right_child = root.right_child.right_child if single_child(root.right_child) && root.right_child.right_child != nil
        root.right_child = root.right_child.left_child if single_child(root.right_child) && root.right_child.left_child != nil
        deleted = true

      else
        root = root.right_child
      end
    end

    not_found = true if leaf(root)
    delete(value, root, deleted, not_found)
  end

  def leaf(root) 
    return true if root.left_child == nil && root.right_child == nil
    return false
  end

  def single_child(root)
    return true if root.right_child == nil || root.left_child == nil
    return false
  end
end

my_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

my_tree.build_tree



my_tree.insert(11)
my_tree.pretty_print
my_tree.delete(5)
my_tree.pretty_print

