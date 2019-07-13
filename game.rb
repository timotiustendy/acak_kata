require './player'

class Game
    attr_accessor :player, :original_word, :question, :question_set, :finished

    def initialize
        self.player = Player.new
        self.question_set = fetch_word
        self.original_word = select_word(self.question_set)
        self.question = randomize_word(self.original_word)
        self.finished = false
    end

    def select_word(words)
        random_index = rand(words.length)

        temp = words[random_index]
        words.delete_at(random_index)

        return temp
    end

    def show_question
        puts("Tebak kata: #{self.question}")
    end

    def check_answer(answer)
        is_true?(answer) ? correct_answer : wrong_answer
    end

    def correct_answer
        self.player.increase_score

        if no_more_question?(self.question_set)
            puts("Tidak ada pertanyaan tersisa. ANDA MENANG!")
            self.finished = true

            return
        end

        self.original_word = select_word(self.question_set)
        self.question = randomize_word(self.original_word)

        puts("BENAR point anda: #{self.player.score}!")
    end

    def wrong_answer
        puts("SALAH! Silakan coba lagi")
    end

    def is_true?(answer)
        return answer == self.original_word
    end

    def exit?(answer)
        return answer.downcase == 'exit'
    end

    def finished?
        return self.finished
    end

    def no_more_question?(question_set)
        return true if (question_set.length == 0)
    end

    private
    def fetch_word
        content = Array.new

        file = File.open('input.txt') or die 'Unable to open file'
        file.each_line do |line|
            content << line[0..-2]
        end

        return content
    end

    def randomize_word(word)
        possible_combinations = Array.new
        generate_combinations(possible_combinations, word.length, Array.new)

        result = ''

        loop do
            random = rand(possible_combinations.length)
            result = build_word(word, possible_combinations[random]).join()

            break if result != word
        end

        return result
    end

    def generate_combinations(results, length, temp)
        if temp.length == length
            results << Array.new(temp)
        else
            for i in 0...length do
                next if temp.include?(i)
                temp << i
                generate_combinations(results, length, temp)
                temp.pop
            end
        end
    end

    def build_word(word, positions)
        result = Array.new(word.length)

        for i in 0...word.length do
            result[i] = word[positions[i]]
        end

        return result
    end
end
