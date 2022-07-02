# frozen_string_literal: true

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

  def build_tree(array)
    array.uniq!.sort!
    array
  end
end

my_tree = Tree.new

p my_tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
