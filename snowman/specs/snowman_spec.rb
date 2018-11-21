require('minitest/autorun')
require('minitest/rg')
require_relative('../snowman.rb')

class SnowmanTest < MiniTest::Test

  def setup
    @player_1 = Player.new("Kevin")
    @hidden_word_1 = HiddenWord.new("Coding Rocks")
    @game = Game.new(@player_1, @hidden_word_1)
  end

  def test_display_hidden_word
    assert_equal("****** *****", @game.display())
  end

  def test_guess_correct
    result = @hidden_word_1.guess_report("c")
    assert_equal(true, result)
  end

  def test_guess_incorrect
    result = @hidden_word_1.guess_report("q")
    assert_equal(false, result)
  end

  def test_make_guess_correct
    result = @game.make_guess("c")
    assert_equal("Correct guess!", result)
  end

  def test_make_guess_incorrect()
    result = @game.make_guess("q")
    assert_equal("Try again!", result)
  end

  def test_make_guess_game_over()
    @game.make_guess("q")
    @game.make_guess("q")
    @game.make_guess("q")
    @game.make_guess("q")
    @game.make_guess("q")
    result = @game.make_guess("q")
    assert_equal("You lose!", result)
  end

  def test_is_won?()
    @game.make_guess("c")
    @game.make_guess("o")
    @game.make_guess("d")
    @game.make_guess("i")
    @game.make_guess("n")
    @game.make_guess("g")
    @game.make_guess("r")
    @game.make_guess("k")
    @game.make_guess("s")
    result = @game.is_won?()
    assert_equal(true, result)
  end

  def test_guess_letters_report()
    assert_equal([], @game.guessed_letters)
  end

end
