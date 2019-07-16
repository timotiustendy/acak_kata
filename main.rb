require './game'

system 'clear'
game = Game.new

puts("===========================")
puts("---------Acak-Kata---------")
puts("===========================")
loop do
    game.show_question

    puts('Jawab:')
    answer = gets.chomp
    system 'clear'

    break if game.exit?(answer)
    puts("===========================")
    game.check_answer(answer)

    if game.clues_available?
        puts("===========================")
        game.offer_clues
        answer = gets.chomp
        puts("~~~~~~~~~~~CLUES~~~~~~~~~~~")
        game.show_clue(answer)
        puts("~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    else
        puts("===========================")
    end

    break if game.finished?
end
