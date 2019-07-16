require './player'
require './question'

class Game
    attr_accessor :player, :current_word, :question_set, :finished, :wrong_count

    def initialize
        self.player = Player.new
        self.question_set = Array.new

        set_questions

        self.current_word = select_word
        self.finished = false
        self.wrong_count = 0
    end

    def show_question
        puts("Tebak kata: #{self.current_word.randomized_word}")
    end

    def check_answer(answer)
        is_true?(answer) ? correct_answer : wrong_answer
    end

    def exit?(answer)
        return answer.downcase == 'exit'
    end

    def finished?
        return self.finished
    end

    def offer_clues
        puts("Tampilkan bantuan? (y/n)") if (self.wrong_count >= 3)
    end

    def clues_available?
        return self.wrong_count >= 3
    end

    def show_clue(answer)
        self.current_word.show_clue if answer.downcase == 'y'
    end

    private
    def correct_answer
        self.player.increase_score

        if no_more_question?(self.question_set)
            puts("Tidak ada pertanyaan tersisa. ANDA MENANG!")
            self.finished = true

            return
        end

        self.current_word = select_word
        self.wrong_count = 0

        puts("BENAR point anda: #{self.player.score}!")
    end

    def wrong_answer
        self.wrong_count += 1

        if (self.wrong_count < self.current_word.original_word.length)
            puts("SALAH! Silakan coba lagi")
        else
            puts("SALAH! Silakan coba lagi (ketik 'exit' untuk berhenti bermain.)")
        end

    end

    def select_word
        random_index = rand(self.question_set.length)

        temp = self.question_set[random_index]
        self.question_set.delete_at(random_index)

        return temp
    end

    def is_true?(answer)
        return answer == self.current_word.original_word
    end

    def set_questions
        content = fetch_word

        content.each do |c|
            new_question = Question.new(c)
            self.question_set << new_question
        end
    end

    def no_more_question?(question_set)
        return true if (question_set.length == 0)
    end

    def fetch_word
        content = Array.new

        file = File.open('input.txt') or die 'Unable to open file'
        file.each_line do |line|
            content << line[0..-2]
        end

        return content
    end
end
