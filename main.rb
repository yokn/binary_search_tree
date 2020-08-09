# frozen_string_literal: true

require_relative 'tree.rb'
my_tree = Tree.new(Array.new(15) { rand(1..100) }.uniq.sort)
my_tree.pretty_print
p my_tree.balanced?

p 'Level order'
p my_tree.level_order
p 'Pre order'
p my_tree.preorder
p 'Post order'
p my_tree.postorder
p 'In order'
p my_tree.inorder

my_tree.insert(120)
my_tree.insert(134)
my_tree.insert(142)
my_tree.pretty_print
p my_tree.balanced?

my_tree.rebalance
my_tree.pretty_print
p my_tree.balanced?

p 'Level order'
p my_tree.level_order
p 'Pre order'
p my_tree.preorder
p 'Post order'
p my_tree.postorder
p 'In order'
p my_tree.inorder
