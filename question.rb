class Question
    attr_accessor :original_word, :randomized_word, :clues_length

    def initialize(word)
        self.original_word = word
        self.randomized_word = randomize_word(word)
        self.clues_length = 0
    end

    def show_clue
        for i in 0...self.original_word.length do
            if (i <= self.clues_length)
                print(self.original_word[i])
            else
                print("_")
            end
        end

        increase_clue_length
    end

    private
    def randomize_word(word)
        initial_position = Array.new
        result = nil

        loop do
            random_position = randomize_char_position(word)
            result = build_word(word, random_position)

            break if (result != self.original_word)
        end

        return result
    end

    def randomize_char_position(word)
        random_position = Array.new

        while true do
            index = rand(word.length)
            if !random_position.include?(index)
                random_position << index
            end

            break if random_position.length == word.length
        end

        return random_position
    end

    def build_word(word, positions)
        result = Array.new(word.length)

        for i in 0...word.length do
            result[i] = word[positions[i]]
        end

        return result.join()
    end

    def increase_clue_length
        if (self.original_word.length > 3)
            self.clues_length += 1 if self.clues_length < self.original_word.length - 4
        else
            self.clues_length += 1 if self.clues_length < self.original_word.length - 3
        end
    end
end
