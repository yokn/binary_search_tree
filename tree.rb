# frozen_string_literal: true

class Tree
  def initialize
    @root = nil
  end

  def build_tree(arr)
    arr.uniq!.sort!
    p arr
  end
end

my_tree = Tree.new
p my_tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
