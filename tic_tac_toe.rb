def all_equal?(arr)
  arr.uniq.size <= 1 && (arr.sample == "x" || arr.sample == "y")
end

def check_winner(array)
array.each do |element|
  if all_equal?(element) then return element.sample end
end

array.transpose.each do |element|
  if all_equal?(element) then return element.sample end
end

left_diagonal = (0..2).collect { |i| array[i][i] }
if all_equal?(left_diagonal) then return left_diagonal.sample end

right_diagonal = []
j = 2
array.each_with_index do |element, index|  
  right_diagonal.push(array[index][j])
  j -= 1
end
if all_equal?(right_diagonal) then return right_diagonal.sample end
end

class Board
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def new_board(board)
    @board = board
  end

  def print_board
    board.each do |square|
      p square
    end
  end
end

class Player
  attr_accessor :name, :move, :turn

  def initialize(name, move, turn)
    @name = name
    @move = move
    @turn = turn
  end
end

def play_game
  player = Player.new('Tet', 'x', 1)
  challenger = Player.new('Beelz', '0', 2)
  new_game = true
  game_end = false
  current_player = player
  while game_end == false do  
  if new_game
    new_game = false
    array = Array.new(3){Array.new(3, "-")}
    board = Board.new(array)
    x = gets.chomp.to_i
    y = gets.chomp.to_i   
       
    array[x][y] = current_player.move
    board.new_board(array)
    board.print_board
    puts "\n"
    current_player = challenger
  else     
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    if array[x][y] == "x" || array[x][y] == "y"
      puts "already exists"
    else  
    array[x][y] = current_player.move
    board.new_board(array)
    board.print_board
    puts "\n"    
    if current_player == player
      current_player = challenger
    else 
      current_player = player 
    end 
    winner = check_winner(array)
    if winner == "x" || winner == "o"
      puts "#{current_player.name} wins"
      break
    end
    end
  end    
end
end

play_game

