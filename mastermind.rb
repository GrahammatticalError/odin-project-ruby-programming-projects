class ComputerPlayer
    attr_reader :code, :guess
    
    def initialize
    end

    def computer_code
        return [rand(6)+1, rand(6)+1, rand(6)+1, rand(6)+1]
    end

    def computer_guess
        return "#{rand(6)+1}#{rand(6)+1}#{rand(6)+1}#{rand(6)+1}"
    end

end

class HumanPlayer
    attr_reader :player_guess

    def initialize
        @player_guess = nil
    end

    def take_guess
        @player_guess = gets.chomp
        @player_guess = @player_guess.split("")
    end

end

class Game
    attr_reader :code
    def initialize
        @code = nil
        @turns = 12
    end

    def take_code(code)
        @code = code
    end

    def check_guess(guess)
        
    end

end

