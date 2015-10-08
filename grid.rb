require 'gridpoint'
require 'cell'

# Represent a whole crossword grid
class Grid
  include Constants

  attr_reader :width, :height, :size

  # raw rows come in as an array of strings with one character per cell,
  # '.' for blank

  def initialize(raw_rows, clues)
    @grid     = []
    @cluelist = []  # For now

    set_dimensions(raw_rows[0].size, raw_rows.size)
    build_grid(raw_rows)
#    add_numbers_and_clues(clues.to_enum)
  end

  private

  def set_dimensions(width, height)
    @width  = width
    @height = height
    @size   = Size.new(width * CELL_SIZE.width, height * CELL_SIZE.height)
  end

  def build_grid(raw_rows)
    raw_rows.each do |row|
      row.each_char { |c| add_cell c }
    end
  end

  def add_cell(c)
    @grid << Cell.new(c)
  end

  def add_clue(clue)
    @cluelist.add(clue, self)
  end

  def cell_at(pos)
    @grid[pos.row * @width + pos.col]
  end

  def each_with_position
    height.times do |row|
      width.times do |col|
        pos = GridPoint.new(row, col)
        yield cell_at(pos), pos
      end
    end
  end

  def word_cells(number, direction)
    gpoint = @cluelist.cell_pos(number, direction)
    word   = [gpoint]

    loop do
      gpoint = @traverser.next_cell(gpoint, direction)
      break if gpoint.nil?
      word << gpoint
    end

    word
  end

  def word_num_from_pos(pos, direction)
    return 0 if cell_at(pos).blank?

    @cluelist.clues_of(direction).each do |clue|
      cells = word_cells(clue.number, direction)
      return clue.number if cells.include? pos
    end

    fail "No word from #{pos}"
  end

  def completed
    each_with_position do |cell, _|
      next if cell.blank?

      return false  if cell.empty?
      return :wrong if cell.error
    end

    :complete
  end

  def add_numbers_and_clues(clues)
    number = 1

    each_with_position do |cell, gpoint|
      next if cell.blank?

      nan = needs_across_number?(gpoint)
      ndn = needs_down_number?(gpoint)

      add_clue(Clue.new(:across, number, clues.next, gpoint)) if nan
      add_clue(Clue.new(:down,   number, clues.next, gpoint)) if ndn

      cell.number = (number += 1) - 1 if nan || ndn
    end
  end

  # Needs an across number if the point
  #   (a) is at the left margin or straight after a blank
  # AND
  #   (b) Not at the right margin and not left of a blank
  def needs_across_number?(gpoint)
    (gpoint.col == 0 || cell_at(gpoint.offset(0, -1)).blank?) &&
      gpoint.col < @width - 1 && !cell_at(gpoint.offset(0, 1)).blank?
  end

  # Needs a down number if the point
  #   (a) is at the very top or below a blank
  # AND
  #   (b) Not at the very bottom and not above a blank
  def needs_down_number?(gpoint)
    (gpoint.row == 0 || cell_at(gpoint.offset(-1, 0)).blank?) &&
      gpoint.row < @height - 1 && !cell_at(gpoint.offset(1, 0)).blank?
  end
end