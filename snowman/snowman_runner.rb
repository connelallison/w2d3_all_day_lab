require_relative('snowman.rb')

p "What is your name?"
@player_1 = Player.new(gets.chomp())

p "What is your secret word or phrase?"
@hidden_word_1 = HiddenWord.new(gets.chomp())
puts `clear`

@game = Game.new(@player_1, @hidden_word_1)
p "The game begins!"

until (@game.is_won?() || @game.is_lost?())
p "Your clue: #{@game.display()}"
p "Your guessed letters: #{@game.guessed_letters}"
p "What is your guess?"
p @game.make_guess(gets.chomp())
end

if (@game.is_won?())
  p "Congratulations! You win!"
end
