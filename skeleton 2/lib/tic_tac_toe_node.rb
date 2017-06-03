require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_positions = []
    @board.rows.size.times do |row_count|
      @board.rows.first.size.times do |col_count|
        empty_positions << [row_count, col_count] if @board.empty?([row_count, col_count])
      end
    end

    nodes = []
    empty_positions.each do |empty_position|
      new_board = Board.new(@board.rows)
      new_board[empty_position] = @next_mover_mark
      new_node = self.class.new(new_board, next_mover_mark == :x ? :o : :x, empty_position)
      nodes << new_node
    end

    nodes
  end
end
