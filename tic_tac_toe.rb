module Helper
  def all_equal?(arr)
    arr.uniq.size <= 1 && (arr.sample == 'x' || arr.sample == 'o')
  end

  def check_winner(array)
    array.each { |element| return element.sample if all_equal?(element) }
    array.transpose.each { |element| return element.sample if all_equal?(element) }
    left_diagonal = (0..2).collect { |i| array[i][i] }
    return left_diagonal.sample if all_equal?(left_diagonal)

    right_diagonal = [array[0][2], array[1][1], array[2, 0]]
    right_diagonal.sample if all_equal?(right_diagonal)
  end
end

class Game
  attr_accessor :players, :board, :round

  include Helper

  def initialize
    @players = []
    @board = Array.new(3) { Array.new(3, '—') }
    @round = 1
  end

  def print_board
    board.each do |element|
      element.each_with_index do |cell, index|
        print cell
        print ' | ' if index < 2
      end
      puts
    end
  end

  def get_players(player_number)
    player = Player.new(player_number)
    @players << player
  end

  def play
    get_players(1)
    get_players(2)
    puts "#{players[0].name} vs #{players[1].name}, start"
    print_board
    game_start
  end

  def print_round
    puts "Round: #{@round}"
  end

  def game_start
    loop do
      if @round > 9
        puts 'DRAW'
        break
      else
        print_round
        if @round.odd?
          puts "Player #{@players[0].name} please choose a square"
          put_move(@players[0])
          if check_winner(@board) == 'x'
            puts "#{@players[0].name} wins"
            break
          end
        else
          puts "Player #{@players[1].name} please choose a square"
          put_move(@players[1])
          if check_winner(@board) == 'o'
            puts "#{@players[1].name} wins"
            break
          end
        end
      end
    end
  end

  def put_move(player)
    move = cords
    check_existing(player, @board, move[0], move[1])
  end

  def cords
    cordinates = gets.chomp

    if cords_satisfy?(cordinates)
      [cordinates[0].to_i, cordinates[2].to_i]
    else
      puts 'Invalid input. Enter cords seperated by space!!'
      print_board
      cords
    end
  end

  def cords_satisfy?(cordinates)
    cordinates.length == 3 && cordinates[0] =~ /^-?[0-2]+$/ && cordinates[1] == ' ' && cordinates[2] =~ /^-?[0-2]+$/
  end

  def check_existing(player, board, x, y)
    if board[x][y] == 'x' || board[x][y] == 'o'
      puts 'already exists, choose another square'
      print_board
      put_move(player)
    else
      board[x][y] = player.move
      print_board
      @round += 1
    end
  end
end

class Player
  attr_accessor :name, :move, :player_number

  def initialize(player_number)
    @player_number = player_number
    puts "Enter player #{player_number} name"
    name = gets.chomp
    @name = name
    move = if player_number == 1
             'x'
           else
             'o'
           end
    @move = move
  end
end

game = Game.new
game.play