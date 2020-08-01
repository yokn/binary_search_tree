# frozen_string_literal: true

require_relative 'node'

class Tree
  def initialize
    # @root = nil
    @sorted = false
  end

  def build_tree(arr)
    puts '-------------------------------------------------------------------'
    unless @sorted
      arr.uniq!.sort!
      @sorted = true
    end
    p arr
    return nil if arr.empty?
    return Node.new(arr[0]) if arr.length == 1

    # return @root if arr.length == 1

    @mid = (arr.length / 2)
    p @mid
    p @root = Node.new(arr[@mid])
    p 'building left'
    p "left was: #{@root.left}"
    @root.left = build_tree(arr[0...@mid])
    p "left is now: #{@root.left}"
    p 'building right'
    p "right is: #{@root.right}"
    @root.right = build_tree(arr[(@mid + 1)..-1])
    p "right is: #{@root.right}"
    @root
  end
end

def pretty_print(node = root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
end

my_tree = Tree.new
pretty_print(my_tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]))
