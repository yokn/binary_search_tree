# frozen_string_literal: true

require_relative 'node'

class Tree
  def initialize
    @sorted = false
  end

  # rubocop:disable Metrics/MethodLength
  def build_tree(arr, first = 0, last = nil)
    # puts '-------------------------------------------------------------------'
    unless @sorted
      arr.uniq!.sort!
      @sorted = true
    end
    # p arr
    last ||= arr.length - 1
    # p "first is: #{first}"
    # p "last is: #{last}"
    return nil if first > last

    mid = (first + last) / 2
    # p "mid is: #{mid}"

    root = Node.new(arr[mid])

    # p 'building left'
    root.left = build_tree(arr, first, mid - 1)
    # p "left is now: #{root.left}"
    # p 'building right'
    root.right = build_tree(arr, mid + 1, last)
    # p "right is now: #{root.right}"
    root
  end

  def insert(number)
    p number
    p root
    result = number <=> root
    p result
    case result
    when 1
      p '1'
    when 0
      p '0'
    when -1
      p '-1'
    end
  end
end

def pretty_print(node = root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
end

my_tree = Tree.new
pretty_print(my_tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]))
my_tree.insert(2)
