# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8],
                    [0, 3, 6],
                    [1, 4, 7],
                    [2, 5, 8],
                    [0, 4, 8],
                    [6, 4, 2]]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts(" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts("-----------")
  puts(" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts("-----------")
  puts(" #{board[6]} | #{board[7]} | #{board[8]} ")
end

#Changes user input to array index
def input_to_index(number)
  number.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if(board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  end
  if (board[index] == "X" || board[index] == "O")
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0,8)
    index_bool = true
  else
    index_bool = false
  end

  position_bool = position_taken?(board, index)

  if index_bool && !position_bool
    return true
  end
end

def turn(board)
  value = current_player(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)

  count = 0

  board.each do |board|
    if (board == "X" || board == "O")
      count += 1
    end
  end
  return count
end

def current_player(board)
  return  turn_count(board).even?? "X" : "O"
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
      (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  false
end

def full?(board)
  am_I_full = board.all? do |position|
    !(position.nil? || position == " ")
  end
  am_I_full
end

def draw?(board)
  if (full?(board) && !won?(board) )
    return true
  elseif (!won?(board) && !full?(board))
    return false
  elseif(won?(board))
    return false
  end
end

def over?(board)
  #true if won, draw, or full
  if(won?(board) || draw?(board) || full?(board))
    return true
  end
  return false
end

def winner(board)
  #check 1st element of win_combination array
  #if "X" return "X" otherwise return "O"
  win_combination = won?(board)

  if !win_combination
    return nil
  end
  #return nil unless win_combination
  if board[win_combination[0]] == "X"
    return "X"
  end
  if board[win_combination[0]] == "O"
    return "O"
  end
end

def play(board)
  until over?(board)
      turn(board)
  end

=begin
if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
=end
  game_result = winner(board)
    if game_result == nil
      puts "Cat's Game!"
    end

    puts "Congratulations #{game_result}!"

end
