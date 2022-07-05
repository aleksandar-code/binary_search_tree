# frozen_string_literal: true
require 'pry-byebug'
# Node class
class Node
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
  attr_accessor :value, :left, :right
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
    root.left = build_tree(array[start_arr.. mid_arr-1], start_arr, mid_arr-1, count)
    root.right = build_tree(array[mid_arr+1.. end_arr], mid_arr+1, end_arr, count)
    root(root)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
# insert method 
# i want to take the root and do a depth first search compare current_root and value
# if current_root > value then value compare to the left child
  def insert(value, root = nil, inserted = false)
    root = @root if root == nil 
    return nil if inserted
    inserted = false
    if root.value > value
      if root.left == nil
        root.left = Node.new(value)
        inserted = true
      end
      root = root.left
    else
      if root.right == nil
        root.right = Node.new(value)
        inserted = true
      end
      root = root.right
    end
    insert(value, root, inserted)
  end
# There are 3 cases 
# 1. We delete a leaf in the tree
# 2. the node has 1 child 
# 3. the node has 2 child
  def delete(value, root = nil, deleted = false, not_found = false)
    return nil if deleted || not_found
    root = @root if root.nil?
    search_next_biggest = nil
    if root.value > value 
      root = root.left
    elsif root.value < value 
      root = root.right
    elsif @root.value == value
      search_next_biggest = @root.right if search_next_biggest.nil?
    elsif root.value == value 

    end


     
    not_found = true if root.nil?
    delete(value, root, deleted, not_found)
  end

end

my_tree = Tree.new([15,14,13,12,11,10,9,8,7,6,5,4,3,2,1])

my_tree.build_tree
my_tree.pretty_print
my_tree.delete(4)
my_tree.pretty_print

