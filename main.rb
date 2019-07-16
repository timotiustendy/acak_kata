require './game'

game = Game.new

loop do
    game.show_question

    puts('Jawab:')
    answer = gets.chomp

    break if game.exit?(answer)
    game.check_answer(answer)

    if game.clues_available?
        game.offer_clues
        answer = gets.chomp
        game.show_clue(answer)
    end

    break if game.finished?
end
