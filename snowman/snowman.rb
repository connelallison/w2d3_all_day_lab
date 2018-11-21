class Player
  attr_reader :name, :lives
  def initialize(name)
    @name = name
    @lives = 5
  end

  def lose_life()
    if (@lives == 0)
      @lives -= 1
      return "You lose!"
    else
      @lives -= 1
      return "Try again!"
    end
  end

end

class HiddenWord

  def initialize(word)
    @word = word.downcase()
  end

  def display(guessed_letters)
    chars = @word.chars()
    chars_changed = chars.reject() { |char| guessed_letters.include?(char) }
    filtered_word = chars.map() { |char| chars_changed.include?(char) ? char = '*' : char = char }
    return filtered_word.join()
  end

  def guess_report(guessed_letter)
    chars = @word.chars()
    return chars.include?(guessed_letter)
  end

  def is_won?(guessed_letters)
    chars = @word.chars()
    chars_changed = chars.reject() { |char| guessed_letters.include?(char) }
    if (chars_changed.count() == 0)
      return true
    else
      return false
    end
  end

end

class Game
  attr_reader :player
  def initialize(player, hidden_word)
    @player = player
    @hidden_word = hidden_word
    @guessed_letters = [" "]
  end

  def display()
    return @hidden_word.display(@guessed_letters)
  end

  def make_guess(guessed_letter)
    if (@hidden_word.guess_report(guessed_letter))
      @guessed_letters.push(guessed_letter)
      return "Correct guess!"
    else
      return @player.lose_life()
    end
  end

    def is_won?()
      return @hidden_word.is_won?(@guessed_letters)
    end

    def is_lost?()
      if (@player.lives >= 0)
        return false
      else
        return true
      end
    end

    def guessed_letters()
      return @guessed_letters.reject() { |char| char != " "}
    end

  end

  # @hidden_word_1 = HiddenWord.new("Coding Rocks")
