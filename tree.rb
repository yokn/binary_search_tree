# frozen_string_literal: true

require_relative 'node'

class Tree
  def initialize(array)
    @sorted = false
    @root = build_tree(array)
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

  # rubocop:disable Metrics/AbcSize
  def insert(number, pointer = @root)
    p "Inserting #{number}"
    p "Currently at #{pointer.data}"
    result = number <=> pointer.data
    # p result
    case result
    when 1
      p 'Number is bigger than the pointer'
      if pointer.right.nil?
        node = Node.new(number)
        pointer.right = node
        p "Inserted #{number} to the right of #{pointer.data}"
        puts ''
        return
      end
      pointer = pointer.right
      insert(number, pointer)
    when 0
      p "Number is equal to the pointer (this shouldn't happen?)"
    when -1
      p 'Number is smaller than the pointer'
      if pointer.left.nil?
        node = Node.new(number)
        pointer.left = node
        p "Inserted #{number} to the left of #{pointer.data}"
        puts ''
        return
      end
      pointer = pointer.left
      insert(number, pointer)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
  end
end

my_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
my_tree.pretty_print

my_tree.insert(2)
my_tree.insert(6)
my_tree.insert(65)
my_tree.pretty_print
