require 'pry'

class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  # getter method for board
  def board 
    @board
  end

  WIN_COMBINATIONS = [
                      [0,1,2],
                      [3,4,5],
                      [6,7,8],
                      [0,3,6],
                      [1,4,7],
                      [2,5,8],
                      [0,4,8],
                      [2,4,6],
                      ]

  # method to display board in current state
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # method to convert user input to viable index 
  def input_to_index(str)
    index = str.to_i - 1
  end

  # method simulating a players turn
  def move(index, player)
    @board[index] = player
  end

  # returns boolean for whether a position on board is taken
  def position_taken?(index, *args)
    @board[index].include?("X") || @board[index].include?("O")
  end

  # returns boolean whether a move is valid
  def valid_move?(index)
    !(position_taken?(index)) && index.between?(0,9)
  end

  # returns count of occupied board positions 
  def turn_count
    @board.count { |move| move == "X" ||  move == "O" }
  end

  # returns the current player 
  def current_player
    if turn_count % 2 == 0
      return "X"
    end
    "O"
  end

  # simulates 1 turn
  def turn
    puts "Please enter a number 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Invalid move"
      puts "Please enter a number 1-9:"
      input = gets.strip 
    end
  end

  # returns boolean whether game is won
  def won?
    WIN_COMBINATIONS.each do |indices|
      ["X", "O"].each do |play|
        if position_taken?(indices[0], indices[1], indices[2]) &&
          board[indices[0]] == play && board[indices[1]] == play && 
          board[indices[2]] == play
          
          return indices
        end
      end
    end
    false
  end

  # returns boolean whether the board is full 
  def full?
    !@board.include?(" ")
  end

  # returns boolean whether the game is a draw 
  def draw?
    full? && !won?
  end

  # returns boolean whether game is over
  def over?
    draw? || won? || full?
  end

  # returns X or O for the winner
  def winner 
    winning_indices = won?
    if winning_indices
      return @board[winning_indices[0]]
    end
    nil
  end

  # play method will simulate a full turn of the game
  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
