# frozen_string_literal: true

require_relative 'node'

# rubocop:disable Metrics/ClassLength
class Tree
  def initialize(arr)
    @sorted = false
    @root = build_tree(arr)
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

  def delete(number, pointer = @root)
    p "deleting #{number}"
    p "Currently at #{pointer.data}"
    result = number <=> pointer.data
    case result
    when 1
      p 'Number is bigger than the pointer'
      if pointer.right.data == number
        delete_right(pointer)
        return
      end
      pointer = pointer.right
      delete(number, pointer)
    when 0
      p 'Number is equal to the pointer'
      pointer.right
    when -1
      p 'Number is smaller than the pointer'
      if pointer.left.data == number
        delete_left(pointer)
        return
      end
      pointer = pointer.left
      delete(number, pointer)
    end
  end

  def delete_left(pointer)
    if pointer.left.left && pointer.left.right
      p 'here'
      delete_both(pointer.left)
    elsif pointer.left.left.nil? && pointer.left.right.nil?
      pointer.left = nil
      pointer.right = nil
    elsif pointer.left.left
      pointer.left = pointer.left.left
      pointer.right = nil
    elsif pointer.left.right
      pointer.right = pointer.left.right
      pointer.left = nil
    end
  end

  def delete_right(pointer)
    if pointer.right.left && pointer.right.right
      delete_both(pointer.right)
    elsif pointer.right.left.nil? && pointer.right.right.nil?
      pointer.left = nil
      pointer.right = nil
    elsif pointer.right.left
      pointer.left = pointer.right.left
      pointer.right = nil
    elsif pointer.right.right
      pointer.right = pointer.right.right
      pointer.left = nil
    end
  end

  def delete_both(pointer)
    smallest = find_smallest(pointer.right)
    p "new smallest: #{smallest.data}"
    pointer.data = smallest.data
    pointer.right = delete(smallest.data, pointer.right)
  end

  def find_smallest(pointer)
    current = pointer
    current = current.left until current.left.nil?
    current
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

my_tree.delete(6)
my_tree.pretty_print
my_tree.delete(65)
my_tree.pretty_print
my_tree.delete(2)
my_tree.pretty_print
my_tree.delete(324)
my_tree.pretty_print
my_tree.delete(4)
my_tree.pretty_print
