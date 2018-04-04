require 'pry'

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

index = 0
player = "X"
board = []

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

# def position_taken?(board, location)
#   board[location] != " " && board[location] != ""
# end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.chomp)
  if valid_move?(board, index) == true
    player = current_player(board)
    move(board, index, player)
    puts "Please enter 1-9:"
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  match = []
  if board.count("X") > board.count("O")
    board.each_with_index do |element, index|
      if element == "X"
        match << index
      end
      WIN_COMBINATIONS.each_with_index do |element, index|
        if (WIN_COMBINATIONS[index]) & match == WIN_COMBINATIONS[index]
          return WIN_COMBINATIONS[index]
        end
      end
    end
  elsif board.count("O") > board.count("X")
    board.each_with_index do |element, index|
      if element == "O"
        match << index
      end
      WIN_COMBINATIONS.each_with_index do |element, index|
        if (WIN_COMBINATIONS[index]) & match == WIN_COMBINATIONS[index]
          return WIN_COMBINATIONS[index]
        end
      end
    end
  else
    return false
  end
end

def full?(board)
  if board.any? { |space| space == " " }
    return false
  elsif board.all? { |space| space == "X" || space == "O" }
    return true
  end
end

def draw?(board)
  if full?(board) && !(won?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if !full?(board) && won?(board)
    return true
  elsif !full?(board) && !won?(board)
    return false
  elsif draw?(board)
    return true
  elsif full?(board) && (won?(board) != false)
    return true
  end
end

def winner(board)
  if won?(board) && (board.count("X") >= 3)
    return "X"
  elsif won?(board) && (board.count("O") >= 3)
    return "O"
  elsif won?(board) || draw?(board)
    return nil
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board).strip}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end
