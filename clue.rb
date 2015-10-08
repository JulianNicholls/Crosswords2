require 'gosu_enhanced'
require './constants'

# Have a clue.
# :reek:TooManyInstanceVariables
class Clue
  include Constants
  include GosuEnhanced

  attr_reader :direction, :number, :text, :point, :region

  NUMBER_WIDTH = 21

  def self.from_text(line)
    dir, num, txt, row, col = line.split ';'
    # rescue => e
    #   puts e.message
    #   puts "'#{line}'"
    #   raise
    # end

    fail "Clue loading problem:\n##{txt}#" if txt[0] != '<' || txt[-1] != '>'
    text = txt[1...-1] # Remove <>

    new(dir.to_sym, num.to_i, text, GridPoint.new(row.to_i, col.to_i))
  end

  def initialize(direction, number, text, point)
    @direction  = direction
    @number     = number
    @text       = text
    @point      = point
  end

  def draw(game, pos, max_width)
    font  = game.font[:clue]
    size  = font.measure(text)
    tlc   = pos.dup

    font.draw(number, pos.x, pos.y, 3, 1, 1, WHITE)

    draw_wrapped(game, pos, text,
                 (size.width / (max_width - NUMBER_WIDTH)).ceil)

    @region = Region(tlc, Size(max_width, pos.y - tlc.y))

    size.height + 1
  end

  def draw_selected(game, pos, max_width)
    new_pos = draw(game, pos, max_width)
    @region.draw(game, 2, CLUE_LIGHT)
    new_pos
  end

  def add_length(len)
    @text += " (#{len})"
  end

  def to_text
    base_text = text.sub(/\s+\(\d+\)$/, '') # Remove word length
    "#{direction};#{number};<#{base_text}>;#{point.row};#{point.col}"
  end

  private

  # :reek:LongParameterList: {max_params: 5}
  def draw_wrapped(game, pos, text, parts)
    TextWrapper.wrap(text, parts).each do |part|
      draw_simple(game, pos, part)
    end
  end

  # :reek:UtilityFunction strictly speaking.
  def draw_simple(game, pos, text)
    font = game.font[:clue]

    font.draw(text, pos.x + NUMBER_WIDTH, pos.y, 3, 1, 1, WHITE)
    pos.move_by!(0, font.height + 1)
  end
end

# Wrap text into a number of pieces
class TextWrapper
  def self.wrap(text, pieces = 2)
    return [text] if pieces == 1

    space = split_point(text, pieces)

    [text[0...space]] + wrap(text[space + 1..-1], pieces - 1)
  end

  # Find the first split point to turn the text into n pieces
  def self.split_point(text, pieces)
    pos = text.size / pieces

    # Find the next and previous spaces, and ...
    nspace = text.index(' ', pos)
    pspace = text.rindex(' ', pos)

    # ... split at the nearest one, biased slightly to the right
    (nspace - pos) > (pos - pspace) ? pspace : nspace
  end
end
