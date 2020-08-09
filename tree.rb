# frozen_string_literal: true

require_relative 'node'
class Tree
  def initialize(arr)
    # @sorted = false
    @root = build_tree(arr)
  end

  def build_tree(arr, first = 0, last = nil)
    # puts '-------------------------------------------------------------------'
    # unless @sorted
    #   arr.uniq!.sort!
    #   @sorted = true
    # end
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

  def find(number, pointer = @root)
    result = number <=> pointer.data
    case result
    when 1
      pointer = pointer.right
      find(number, pointer)
    when 0
      pointer
    when -1
      pointer = pointer.left
      find(number, pointer)
    end
  end

  def level_order(pointer = @root, queue = [], array = [])
    # return if pointer.nil?

    queue << pointer

    until queue.empty?
      current = queue[0]
      array << current.data
      queue << current.left if current.left
      queue << current.right if current.right
      queue.shift
    end
    array
  end

  def preorder(pointer = @root, array = [])
    return if pointer.nil?

    array << pointer.data
    preorder(pointer.left, array)
    preorder(pointer.right, array)
    array
  end

  def inorder(pointer = @root, array = [])
    return if pointer.nil?

    inorder(pointer.left, array)
    array << pointer.data
    inorder(pointer.right, array)
    array
  end

  def postorder(pointer = @root, array = [])
    return if pointer.nil?

    preorder(pointer.left, array)
    preorder(pointer.right, array)
    array << pointer.data
  end

  def depth(pointer = @root, levels = -1)
    return levels if pointer.nil?

    # pointer = find(pointer)

    left_depth = depth(pointer.left)
    right_depth = depth(pointer.right)
    left_depth > right_depth ? left_depth + 1 : right_depth + 1
  end

  # def balanced?(pointer = @root)
  #   (depth(pointer.left) - depth(pointer.right)).abs < 2 ? 'balanced' : 'unbalanced'
  # end

  def balanced?(pointer = @root)
    return true if pointer.nil?

    left_depth = depth(pointer.left)
    right_depth = depth(pointer.right)

    return true if (left_depth - right_depth).abs < 2 && balanced?(pointer.left) && balanced?(pointer.right)

    false
  end

  def rebalance
    @root = build_tree(level_order.uniq.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
  end
end

my_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].uniq.sort)
my_tree.pretty_print

my_tree.insert(2)
my_tree.insert(6)
my_tree.insert(65)
my_tree.pretty_print

# my_tree.delete(6)
# my_tree.pretty_print
# my_tree.delete(65)
# my_tree.pretty_print
# my_tree.delete(2)
# my_tree.pretty_print
# my_tree.delete(324)
# my_tree.pretty_print
# my_tree.delete(4)
# my_tree.pretty_print
my_tree.delete(67)
my_tree.pretty_print

p 'Finding node: 9'
p my_tree.find(9)

p 'Level order'
p my_tree.level_order
p 'Pre order'
p my_tree.preorder
p 'In order'
p my_tree.inorder
p 'Post order'
p my_tree.postorder

p 'Depth of 2 is:'
p my_tree.depth(my_tree.find(2))
p 'Depth of 8 is:'
p my_tree.depth(my_tree.find(8))

my_tree.pretty_print
p my_tree.balanced?

my_tree.rebalance

my_tree.pretty_print
p my_tree.balanced?
