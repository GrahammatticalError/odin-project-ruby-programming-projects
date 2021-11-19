class ComputerCode
    attr_reader :code
    
    def initialize
        @code = [rand(6)+1, rand(6)+1, rand(6)+1, rand(6)+1]
    end

end

puzzle = ComputerCode.new()

puts puzzle.code