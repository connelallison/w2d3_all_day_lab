require_relative('snowman.rb')

puts "What is your name?"
@player_1 = Player.new(gets.chomp())

puts "What is your secret word or phrase?"
@hidden_word_1 = HiddenWord.new(gets.chomp())
puts `clear`

@game = Game.new(@player_1, @hidden_word_1)
puts "The game begins!"

until (@game.is_won?() || @game.is_lost?())
puts "Your clue: #{@game.display()}"
puts "Your guessed letters: #{@game.guessed_letters}"
puts "You have #{@game.lives()} remaining."
puts "What is your guess?"
puts @game.make_guess(gets.chomp())
end

if (@game.is_won?())
  puts "The answer was '#{@game.display()}'"
  puts "Congratulations! You win!"
end
