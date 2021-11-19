class ComputerPlayer
    attr_reader :code, :guess
    
    def initialize
        @code = []
        @possible_answers = [1, 2, 3, 4, 5, 6]
    end

    def pick_number
        return @possible_answers[rand(@possible_answers.length)].to_s
    end

    def computer_code
        @code = []
        4.times do
            @code = @code.push(pick_number())            
        end
        return @code
    end

#    def next_guess(hint)
#        case hint
#        when ""
#            @possible_answers = @possible_answers - @code
#            @code = []
#            computer_code()
#            return @code
#        end
#    end

end

class HumanPlayer
    attr_accessor :code

    def initialize
        @code = []
    end

    def get_code
        @code = []
        @code = gets.chomp.split("")
        return @code
    end

end

class Game
    attr_reader :code, :hint
    attr_accessor :hint,
    def initialize
        @code = nil
        @turns = 12
        @hint = []
    end

    def take_code(code)
        @code = code
    end

    def correct_spot
        @hint = @hint.unshift("O")
    end

    def incorrect_spot
        @hint = @hint.push("X")
    end

    def index_match(guess, code)
        i = 0
        guess.each do |num|
            if code[i] == num
                correct_spot()
                code[i] = "used"
                guess[i] = "done"
            end
            i +=1
        end
    end

    def value_match(guess, code)
        guess.each do |num|
            if code.include?(num)
                incorrect_spot()
                code[code.index(num)] = "used"
            end
        end
    end


    def check_guess(guess)
        @hint = []
        code = @code.dup
        gdup = guess
        index_match(gdup, code)
        value_match(gdup, code)
    end
end

c = ComputerPlayer.new()
p1 = HumanPlayer.new()
game = Game.new()

def game_loop(c, p1, game)
    game.take_code(c.computer_code)
    12.times do
        puts "What is your guess?"
        game.check_guess(p1.get_code)
        if game.hint == ["O", "O", "O", "O"]
            puts "Congratulations!"
            break
        else 
            print game.hint.join("")+"\n"
        end
    end
    puts "Would you like to play again? Y or N"
    again = gets.chomp.downcase
    if again == "y"
        game_loop(c, p1, game)
    end
end

game_loop(c, p1, game)

#game.take_code(c.computer_code)
#p game.code
#puts "What is your guess, HUUUUman?"
#game.check_guess(p1.get_code)
#p game.code
#p game.hint