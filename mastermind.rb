class ComputerPlayer
    attr_reader :code, :first_guess
    attr_accessor :best_guess, :educated_guess

    def initialize
        @code = []
        @possible_answers = [1, 2, 3, 4, 5, 6]
        @best_guess = []
        @first_guess = [1,1,1,1]
        @educated_guess = []
    end

    def pick_number
        return @possible_answers[rand(@possible_answers.length)]
    end

    def computer_code
        @code = []
        4.times do
            @code = @code.push(pick_number())            
        end
        return @code
    end

    def hint_score(hint)
        hint.each do |e|
            if e == "X"
                hint[hint.index(e)] = 1
            else
                hint[hint.index(e)] = 10
            end
        end
        hint.sum
    end

    def computer_guess(hint)
        if @educated_guess.length < 4
            hint.length.times do
                @educated_guess.push(@best_guess[0])
            end
        end
        if @best_guess == []
            @best_guess = @first_guess
            p @first_guess
            return @first_guess
        elsif @educated_guess.length < 4
            @best_guess.map! {|i| i += 1}
            p @best_guess
            return @best_guess
        elsif @educated_guess.length == 4
            score = hint_score(hint)
            if score == 4
                arr = [@educated_guess[3],@educated_guess[0],@educated_guess[1],@educated_guess[2]]
                @educated_guess = arr
                p @educated_guess
                return @educated_guess
            elsif score == 13
                arr = [@educated_guess[0],@educated_guess[3],@educated_guess[1],@educated_guess[2]]
                @educated_guess = arr
                p @educated_guess
                return @educated_guess
            elsif score == 22
                arr = [@educated_guess[0],@educated_guess[1],@educated_guess[3],@educated_guess[2]]
                @educated_guess = arr
                p @educated_guess
                return @educated_guess
            else
                @best_guess = @educated_guess
                p @educated_guess
                return @educated_guess
            end
        end
    end


    
end

class HumanPlayer
    attr_accessor :code

    def initialize
        @code = []
    end

    def get_code
        @code = []
        @code = gets.chomp.split("")
        @code.map! {|s| s.to_i}
        return @code
    end

end

class Game
    attr_reader :code, :hint
    attr_accessor :hint, :code
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
    puts "Would you like to set the code or break the code?"
    puts "Press 1 to set the code. Press 2 to break the code."
    code_creator = gets.chomp
    if code_creator == "1"
        puts "What would you like the code to be? I promise I won't tell."
        game.take_code(p1.get_code)
        computer_guess(c, p1, game)
    elsif code_creator == "2"
        game.take_code(c.computer_code)
        player_guess(c, p1, game)
    else
        puts "Please only enter 1 or 2"
        game_loop(c, p1, game)
    end
end

def player_guess(computer, player, game)
    12.times do
        puts "What is your guess?"
        p game.code
        game.check_guess(player.get_code)
        if game.hint == ["O", "O", "O", "O"]
            puts "Congratulations!"
            break
        else
            puts "Incorrect. Here is your hint:" 
            print game.hint.join("")+"\n"
        end
    end
    puts "Would you like to play again? Y or N"
    again = gets.chomp.downcase
    if again == "y"
        game_loop(ComputerPlayer.new(), HumanPlayer.new(), Game.new())
    elsif again == "n"
        puts "Thanks for playing!"
    end
end

def computer_guess(computer, player, game)
    12.times do
        puts "The computer is guessing...."
        sleep 1
        game.check_guess(computer.computer_guess(game.hint))
        if game.hint == ["O", "O", "O", "O"]
            puts "Sorry, the computer broke your code!"
            break
        else
            puts "The computer is incorrect! Here is it's hint:" 
            print game.hint.join("")+"\n"
        end
    end
    puts "Would you like to play again? Y or N"
    again = gets.chomp.downcase
    if again == "y"
        game_loop(ComputerPlayer.new(), HumanPlayer.new(), Game.new())
    elsif again == "n"
        puts "Thanks for playing!"
    end
end

puts "This is the game of Master Mind!" 
puts "One player sets a four digit code of integers from 1 to 6, and the other has 12 tries to guess it."
puts "After each guess a hint is given. An 'X' is a correct number but incorrect placement."
puts "An 'O' is a correct number and a correct placement."
puts "Are you ready to play?"
if gets 
    game_loop(c, p1, game)
else
    puts "Okay.... :("
end
