class Player
    attr_accessor :score

    def initialize
        self.score = 0
    end

    def increase_score
        self.score += 1
    end
end
