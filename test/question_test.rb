require 'test/unit'
require './question'

class QuestionTest < Test::Unit::TestCase
    def setup
        @question = Question.new('book')
    end

    test 'original and randomized word' do
        assert_not_equal(@question.original_word, @question.randomized_word, "Question randomized word is not original_word.")
    end

    test 'randomized word is never original word' do
        is_not_randomized = false

        for i in 0...1000 do
            question = Question.new('boo')

            if (question.original_word == question.randomized_word)
                is_not_randomized = true
                break
            end
        end

        assert(!is_not_randomized, "Question will never be original word.")
    end
end
