# Representation of a crossword grid
class Grid
  # Represent one cell in the crossword with its solution letter, user entry,
  # possible number, and highlight state.
  class Cell
    attr_reader :letter, :user, :error

    def self.from_text(line)
      letter, user, num = line.split ','

      me = new(letter)
      me.add_index(num.to_i) unless num.empty?
      me.user = user

      me
    end

    def initialize(letter)
      @letter     = letter
      @user       = ''
      @number     = 0
      @error      = false
    end

    def add_index(num)
      @number = num
    end

    # Black means a black square
    def blank?
      @letter == '.'
    end

    # Empty means not filled in by user
    def empty?
      user.empty?
    end

    def user=(ltr)
      @user  = ltr
      @error = user != '' && letter != user
    end

    def to_text
      "#{letter},#{user},#{number}"
    end

    def draw(window, highlight)
    end
  end
end
