class Board
    attr_reader :c1, :c2, :c3, :c4, :c5, :c6, :c7, :c8, :c9
    
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
        @conditions_of_victory = [
            # horizontal
            [@c1, @c2, @c3], #0
            [@c4, @c5, @c6], #1
            [@c7, @c8, @c9], #2
            # vertical
            [@c1, @c4, @c7], #3
            [@c2, @c5, @c8], #4
            [@c3, @c6, @c9], #5
            #diagonal
            [@c1, @c5, @c9], #6
            [@c7, @c5, @c3] #7
        ]
    end

    def mark_board (mark, location)
        @marked_board = @marked_board.sub(location, mark)
        case location
        when "1"
            @c1 = mark
            @conditions_of_victory[0][0] = mark
            @conditions_of_victory[3][0] = mark
            @conditions_of_victory[6][0] = mark
        when "2"
            @c2 = mark
            @conditions_of_victory[0][1] = mark
            @conditions_of_victory[4][0] = mark
        when "3"
            @c3 = mark
            @conditions_of_victory[0][2] = mark
            @conditions_of_victory[5][0] = mark
            @conditions_of_victory[7][2] = mark
        when "4"
            @c4 = mark
            @conditions_of_victory[1][0] = mark
            @conditions_of_victory[3][1] = mark
        when "5"
            @c5 = mark
            @conditions_of_victory[1][1] = mark
            @conditions_of_victory[4][1] = mark
            @conditions_of_victory[6][1] = mark
            @conditions_of_victory[7][1] = mark
        when "6"
            @c6 = mark
            @conditions_of_victory[1][2] = mark
            @conditions_of_victory[5][1] = mark
        when "7"
            @c7 = mark
            @conditions_of_victory[2][0] = mark
            @conditions_of_victory[3][2] = mark
            @conditions_of_victory[7][0] = mark
        when "8"
            @c8 = mark
            @conditions_of_victory[2][1] = mark
            @conditions_of_victory[4][2] = mark
        when "9"
            @c9 = mark
            @conditions_of_victory[2][2] = mark
            @conditions_of_victory[5][2] = mark
            @conditions_of_victory[6][2] = mark
        end
    end
    
    def show_board
        puts @marked_board
    end

    def conditions_of_victory
        return @conditions_of_victory
    end


    def clear_board
        @marked_board = @board
        @c1, @c2, @c3, @c4, @c5, @c6, @c7, @c8, @c9 = "1", "2", "3", "4", "5", "6", "7", "8", "9"
        puts @marked_board
    end

end

class Player
    attr_reader :mark, :turner, :name, :available_moves
    attr_accessor :turn, :score

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

    def available_moves
        return @@available_moves
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
        if @@available_moves.include? input.to_i
            @@available_moves.delete(input.to_i)
            @@turner += 1
            input
        else 
            puts "That move was already taken."
            takes_move
        end
    end

    def reset_player
        @@available_moves = @@moves.dup
    end
end

puts "What is player 1's name?"
player1 = Player.new(gets.chomp, "X", 1)
puts "What is player 2's name?"
player2 = Player.new(gets.chomp, "O", 0)


def player_win?(board, mark)
    board.conditions_of_victory.any? do |arr| 
        arr.all? { |elem| elem == mark}
    end
end

def play_game(p1, p2, board)
    9.times do
        if player_win?(board, "X")
            break
        elsif player_win?(board, "O")
            break
        else
            if p1.is_turn?
                puts "It is your turn #{p1.name}"
                board.mark_board(p1.mark, p1.takes_move)
                board.show_board
            else
                puts "It is your turn #{p2.name}"
                board.mark_board(p2.mark, p2.takes_move)
                board.show_board
            end
        end
    end
    
    if player_win?(board, "X")
        puts "Congratulations #{p1.name}. You are victorious."
        p1.score += 1
    elsif player_win?(board, "O")
        puts "Congratulation #{p2.name}. You are the champion."
        p2.score += 2
    else
        puts "Draw." 
    end
    puts "The score is currently #{p1.name}: #{p1.score} to #{p2.name}: #{p2.score}."
    puts "Would you like to play again?(Y or N)"
    response = gets.chomp
    if response == "Y" || response == "y" 
        p1.reset_player
        p2.reset_player
        play_game(p1, p2, Board.new())
    else
        puts "Thanks for playing!"
    end
end

play_game(player1, player2, Board.new())




