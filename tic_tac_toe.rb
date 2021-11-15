class Board
    attr_reader :c1, :c2, :c3, :c4, :c5, :c6, :c7, :c8, :c9
    @@conditions_of_victory = [
        # horizontal
        [@c1, @c2, @c3],
        [@c4, @c5, @c6],
        [@c7, @c8, @c9],
        # vertical
        [@c1, @c4, @c7],
        [@c2, @c5, @c8],
        [@c3, @c6, @c9],
        #diagonal
        [@c1, @c5, @c9],
        [@c7, @c5, @c3]
    ]
    def initialize
        @c1, @c2, @c3, @c4, @c5, @c6, @c7, @c8, @c9 = "1", "2", "3", "4", "5", "6", "7", "8", "9"
        @board = "
        |   |   
      1 | 2 | 3  
     ___|___|___
        |   |   
      4 | 5 | 6 
     ___|___|___
        |   |   
      7 | 8 | 9 
        |   |"
        @marked_board = @board.dup
        puts @board
    end

    def mark_board (mark, location)
        @marked_board = @marked_board.sub(location, mark)
        case location
        when "1"
            @c1 = mark
        when "2"
            @c2 = mark
        when "3"
            @c3 = mark
        when "4"
            @c4 = mark
        when "5"
            @c5 = mark
        when "6"
            @c6 = mark
        when "7"
            @c7 = mark
        when "8"
            @c8 = mark
        when "9"
            @c9 = mark
        end
    end
    
    def show_board
        puts @marked_board
    end

    def clear_board
        @marked_board = @board
        @c1, @c2, @c3, @c4, @c5, @c6, @c7, @c8, @c9 = "1", "2", "3", "4", "5", "6", "7", "8", "9"
        puts @marked_board
    end

end

class Player
    attr_reader :mark, :turner, :name, :available_moves
    attr_accessor :turn

    @@moves = [1,2,3,4,5,6,7,8,9]
    @@available_moves = @@moves.dup
    @@turner = rand(100).to_i 
    def initialize(name, mark, tmod)
        @name = name
        @mark = mark
        @score = 0
        @turn = nil
        @tmod = tmod
    end

    def show_available_moves
        puts @@available_moves
    end
    def show_turner
        puts @@turner
    end

    def is_turn?
        @@turner % 2 == @tmod
    end

    def takes_move
        puts "In which unoccupied space (#{@@available_moves}) would you like to place your mark?"
        input = gets.chomp
        @@available_moves.delete(input.to_i)
        @@turner += 1
        input
    end

    def reset_player
        @@available_moves = @@moves.dup
    end
end

puts "What is player 1's name?"
player1 = Player.new(gets.chomp, "X", 1)
puts "What is player 2's name?"
player2 = Player.new(gets.chomp, "O", 0)
board = Board.new()

def play_game(p1, p2, board)
    until p1.available_moves == []
        if p1.is_turn?
            puts "It is your turn #{p1.name}"
            board.mark_board(p1.mark, p1.takes_move)
            board.show_board
            p1.show_available_moves
        else
            puts "It is your turn #{p2.name}"
            board.mark_board(p2.mark, p2.takes_move)
            board.show_board
            p1.show_available_moves
        end
    end
end

play_game(player1, player2, board)




