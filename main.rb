require './game'

game = Game.new

loop do
    game.show_question

    puts('Jawab:')
    answer = gets.chomp

    break if game.exit?(answer)
    game.check_answer(answer)
    break if game.finished?
end
