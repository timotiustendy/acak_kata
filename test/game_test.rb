require 'test/unit'
require './game'

class GameTest < Test::Unit::TestCase
    def setup
        @game = Game.new
    end

    test 'exit game' do
        assert(@game.exit?('exit'), "Game exit correctly.")
    end

    test 'exit_game_fail' do
        assert(!@game.exit?('other'), "Game does not exit correctly.")
    end

    test 'player score increase' do
        before_answer = @game.player.score
        @game.check_answer(@game.current_word.original_word)
        after_answer = @game.player.score

        assert(after_answer > before_answer, "Player score increase when answer is corrent.")
    end

    test 'show question' do
        assert_not_equal(@game.show_question, @game.current_word.original_word, "Game question is not original word.")
    end

    test 'check correct answer' do
        assert_equal(@game.check_answer(@game.current_word.original_word), puts("BENAR point anda: #{@game.player.score}!"), "Game tells user current score when answer is correct.")
    end

    test 'check wrong answer' do
        assert_equal(@game.check_answer(''), puts("SALAH! Silakan coba lagi"), "Game tells user when answer is wrong.")
    end

    test 'game finish' do
        @game.current_word = @game.question_set[0]
        @game.question_set = Array.new

        assert_equal(@game.check_answer(@game.current_word.original_word), puts("Tidak ada pertanyaan tersisa. ANDA MENANG!"), "Game tells user when game is finished.")
        assert(@game.finished? && @game.question_set.length == 0, "Game is finished when no question is left to answer.")
    end
end
