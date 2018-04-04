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
  # if board.all?{ |space| space == " " }
  #   return false
  # elsif board[0] == "X" && board[1] == "X" && board[2] == "X"
  #   return WIN_COMBINATIONS[0]
  # elsif (board[3] == "X" && board[4] == "X" && board[5] == "X") || (board[3] == "O" && board[4] == "O" && board[5] == "O")
  #   return WIN_COMBINATIONS[1]
  # elsif board[6] == "X" && board[7] == "X" && board[8] == "X" || board[6] == "O" && board[7] == "O" && board[8] == "O"
  #   return WIN_COMBINATIONS[2]
  # elsif board[0] == "O" && board[3] == "O" && board[6] == "O"
  #   return WIN_COMBINATIONS[3]
  # elsif board[1] == "O" && board[4] == "O" && board[7] == "O"
  #   return WIN_COMBINATIONS[4]
  # elsif board[2] == "O" && board[5] == "O" && board[8] == "O" || board[2] == "X" && board[5] == "X" && board[8] == "X"
  #   return WIN_COMBINATIONS[5]
  # elsif board[0] == "X" && board[4] == "X" && board[8] == "X"
  #   return WIN_COMBINATIONS[6]
  # elsif board[2] == "O" && board[4] == "O" && board[6] == "O"
  #   return WIN_COMBINATIONS[7]
  # elsif board.all?{ |space| space == "X" || space == "O" }
  #   return false
  # end

  # if board.all?{ |space| space == " " }
  #   return false
  # elsif
  #
  # elsif board.all?{ |space| space == "X" || space == "O" }
  #   return false

  # we want to take each item in the board array and create an array
    # and compare each of those arrays to each of the arrays in the WIN_COMBINATIONS array

    # in board, find each element that matches X or O
    #   and return an array with their indexes
    # return a comparison of the intersection of that array with every array within WIN_COMBINATIONS

    # if they match, return WIN_COMBINATIONS[]
    # else, return false

  match = []
  if board.count("X") > board.count("O")
    board.each_with_index do |element, index|
      if element == "X"
        match << index
      end
      WIN_COMBINATIONS.each_with_index do |element, index|
        unless (WIN_COMBINATIONS[index]) & match == WIN_COMBINATIONS[index]
          return false
        else
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

  # board.each_with_index { |element, index|
  #   if (element[index] == element[index.to_i + 1]) && (element[index] == element[index.to_i + 2])
  #     match << [index]
  #     match << [index.to_i + 1]
  #     match << [index.to_i + 2]
  #     return match
  #   elsif (element[index] == element[index.to_i + 3]) && (element[index] == element[index.to_i + 6])
  #     match << [index]
  #     match << [index.to_i + 3]
  #     match << [index.to_i + 6]
  #     return match
  #   elsif (element[index] == element[index.to_i + 4]) && (element[index] == element[index.to_i + 8])
  #     match << [index]
  #     match << [index.to_i + 4]
  #     match << [index.to_i + 8]
  #     return match
  #   elsif (element[index] == element[index.to_i + 2]) && (element[index] == element[index.to_i + 4])
  #     match << [index]
  #     match << [index.to_i + 2]
  #     match << [index.to_i + 4]
  #     return match
  #   else
  #     return false
  #   end
  # }
  binding.pry
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
