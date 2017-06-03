# 00_tree_node.rb
require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(node)
    if @parent
      @parent.children.delete(self)
    end

    @parent = node

    if node
      node.children.push(self) unless node.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value, &prc)
    prc ||= Proc.new { |node, value| node.value == value }
    return self if prc.call(self, target_value)
    @children.each do |child|
      result = child.dfs(target_value, &prc)
      return result if result
    end
    nil
  end

  def bfs(target_value, &prc)
    prc ||= Proc.new {|node,value| node.value == value}
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if prc.call(node,target_value)
      queue.concat(node.children)
    end
    nil
  end

  # def children
  #   @children.dup
  # end

end

if __FILE__ == $PROGRAM_NAME
  n1 = PolyTreeNode.new("1")
  n2 = PolyTreeNode.new("2")
  n3 = PolyTreeNode.new("3")
  n4 = PolyTreeNode.new("4")

  n2.parent = n1
  n3.parent = n1
  n4.parent = n3

  #p n1.dfs('2') { |node, value| node.value.to_i > value.to_i }
  p n1.bfs('2') { |node, value| node.value.to_i > value.to_i }
  # # connect n3 to n1
  # n3.parent = n1
  # # connect n3 to n2
  # n3.parent = n2
  #
  # # this should work
  # raise "Bad parent=!" unless n3.parent == n2
  # raise "Bad parent=!" unless n2.children == [n3]
  #
  # # this probably doesn't
  # raise "Bad parent=!" unless n1.children == []
end
