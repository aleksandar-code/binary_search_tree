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
    # binding.pry
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
  def delete(value, root = nil, deleted = false, not_found = false, current_root = nil)
    return nil if deleted || not_found
    root = @root if root.nil?
    if root.value < value 
      delete(value, root.right, deleted, not_found) if deleted == false
      root.right = nil if root.right.value == value
      return
    elsif root.value > value 
      delete(value, root.left, deleted, not_found) if deleted == false
      root.left = nil if root.left.value == value 
      return 
    elsif @root.value == value
      current_root = @root.right if current_root.nil?
      if !(current_root.left.nil?)
        current_root = current_root.left 
      else
        value = current_root.value
        delete(current_root.value, @root, deleted, not_found)
        @root.value = value
        deleted = true
      end
    else
      if root.value == value 
        if root.right.nil? && root.left.nil? # no child
          root = nil
          deleted = true
        else
          if root.value < value 
            delete(value, root.right, deleted, not_found) if deleted == false
          elsif root.value > value 
            delete(value, root.left, deleted, not_found) if deleted == false
          end
          if root.left.nil? # 1 child 
            root.value = root.right.value 
            root.right = nil
            deleted = true 
          elsif root.right.nil?
            root.value = root.left.value
            root.left = nil
            deleted = true
          end
          if !(root.right.nil? && root.left.nil?) # 2 childs
            current_root = root.right if current_root.nil?
            if !(current_root.left.nil?)
              current_root = current_root.left 
            else
              value = current_root.value
              delete(current_root.value, root, deleted, not_found)
              root.value = value
              deleted = true
            end
          end 
        end
      end
    end 
    not_found = true if root.nil?
    delete(value, root, deleted, not_found, current_root)
  end

  def find(value, root = false, found = false)
    root = @root if root == false
    if !(root.nil?) && root.value == value 
      print "node: " 
      p root 
      found = true
    end 
      return puts "#{!(root.nil?)}" if root.nil? || found == true
    if root.value < value
      find(value, root.right, found) if found == false
    elsif root.value > value
      find(value, root.left, found) if found == false
    end
  end
  
  def level_order
    queue = []
    array = []
    queue.push(@root)
    while !(queue.empty?)
      current_root = queue.first
      queue.push(current_root.left)  if !(current_root.left.nil?)
      queue.push(current_root.right)  if !(current_root.right.nil?)
      if !(block_given?)
        array << current_root.value
      else
        yield(current_root)
      end
      queue = queue[1..]
    end
    print "\n\n"
    return array if !(block_given?) 
  end

  def preorder(array = [], current_root=false, &block)
    if current_root.nil? && block_given?
      return 
    elsif current_root.nil? && !(block_given?)
      return array
    end
    current_root = @root if current_root == false
    if block_given?
      yield(current_root)
    else
      array << current_root.value
    end
    
    preorder(array, current_root.left, &block)
    preorder(array, current_root.right, &block)
  end

  def inorder(array = [], current_root=false, &block)
    if current_root.nil? && block_given?
      return 
    elsif current_root.nil? && !(block_given?)
      return array
    end
    current_root = @root if current_root == false
    inorder(array, current_root.left, &block)
    if block_given?
      yield(current_root)
    else
      array << current_root.value
    end
    
    inorder(array, current_root.right, &block)
  end

  def postorder(array = [], current_root=false, &block)
    if current_root.nil? && block_given?
      return 
    elsif current_root.nil? && !(block_given?)
      return array
    end
    current_root = @root if current_root == false
    postorder(array, current_root.left, &block)
    postorder(array, current_root.right, &block)
    if block_given?
      yield(current_root)
    else
      array << current_root.value
    end
  end

  def depth_(value, root = false, found = false, depth = 0)
    root = @root if root == false
    
    if !(root.nil?) && root.value == value 
      found = true
    end 

      return puts "depth of #{value}: #{depth}" if root.nil? || found == true

    if root.value < value
      depth += 1
      depth_(value, root.right, found, depth) if found == false
    elsif root.value > value
      depth += 1
      depth_(value, root.left, found, depth) if found == false
    end

  end

  def height(value, root = false, found = false, height_left = 0, height_right = 0)
    root = @root if root == false
    if !(root.nil?) && root.value == value 
      found = true
      if root.left.nil? && root.right.nil?
        puts "height of #{value}: 0" 
        return 0 
      end
      if !(root.left.nil? && root.right.nil?)
        current_root_left = root 
        until (current_root_left.left.nil? && current_root_left.right.nil?)
          current_root_left = current_root_left.left
          height_left += 1
        end
        current_root_right = root 
        until (current_root_right.left.nil? && current_root_right.right.nil?)
          current_root_right = current_root_right.right
          height_right += 1
        end
      end
      if (current_root_left.left.nil? && current_root_left.right.nil?)
        if height_left > height_right
          height = height_left
        elsif height_left < height_right
          height = height_right
        else
          height = height_right
        end
        puts "height of #{value}: #{height}"
        return height
      end
    end 

    if root.nil? || found == true && !(root.left.nil? && root.right.nil?)
      puts "height of #{value}: #{height}"
      return height
    end

    if root.value < value
      height(value, root.right, found) if found == false
    elsif root.value > value
      height(value, root.left, found) if found == false
    end

  end

  def balanced?(left_tree = false, right_tree = false, balanced = false, not_balanced = false)
    left_tree = @root.left if left_tree == false
    right_tree = @root.right if right_tree == false
    
    
    left = height(left_tree.value)
    right = height(right_tree.value)
    
    if right > left && right <= left + 1 || left > right && left <= right + 1 || left == right 
      balanced = true
    else 
      not_balanced = true
    end 
    
    balanced?(left_tree.left, left_tree.right, balanced, not_balanced) if !(left_tree.left.nil?) && !(left_tree.right.nil?)
    
    balanced?(right_tree.left, right_tree.right , balanced, not_balanced) if !(right_tree.left.nil?) && !(right_tree.right.nil?)
   
    if not_balanced == false && balanced == true
      return puts "balanced" 
    else
      return puts "not balanced"
    end
  end

  def rebalance
    if current_root.nil? && block_given?
      return 
    elsif current_root.nil? && !(block_given?)
      return array
    end
    current_root = @root if current_root == false
    inorder(array, current_root.left, &block)
    if block_given?
      yield(current_root)
    else
      array << current_root.value
    end
    
    inorder(array, current_root.right, &block)
  end

end

my_tree = Tree.new([15,14,13,12,11,10,9,8,7,6,5,4,3,2,1])
my_tree.build_tree
my_tree.pretty_print

my_tree.balanced? 