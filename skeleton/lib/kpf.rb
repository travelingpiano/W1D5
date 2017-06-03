# kpf.rb
require_relative '00_tree_node'
require 'byebug'

class KnightPathFinder
  DELTAS = [[-2,-1],
            [-2,1],
            [-1,-2],
            [-1,2],
            [1,-2],
            [1,2],
            [2,-1],
            [2,1]]


  def self.valid_moves(pos)
    DELTAS.map do |delta|
      [pos[0]+delta[0],pos[1]+delta[1]]
    end.select do |moved_pos|
      (0...8).cover?(moved_pos[0]) && (0...8).cover?(moved_pos[1])
    end
  end

  def initialize(pos)
    @pos = pos
    build_move_tree
  end

  def build_move_tree
    # byebug
    @visited_positions = [@pos]
    @root = PolyTreeNode.new(@pos)
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      current_position = current_node.value
      candidate_positions = new_move_positions(current_position)
      @visited_positions += candidate_positions
      candidate_positions.each do |candidate_position|
        candidate_node = PolyTreeNode.new(candidate_position)
        candidate_node.parent = current_node
        queue << candidate_node
      end
    end
  end

  def find_path(end_pos)
    end_node = @root.dfs(end_pos)
    moves = [end_node.value]
    while end_node.parent
      end_node = end_node.parent
      moves << end_node.value
    end
    moves.reverse
  end

  def new_move_positions(pos)
    self.class.valid_moves(pos) - @visited_positions
  end


end

p KnightPathFinder.new([0, 0]).find_path([6, 2])
