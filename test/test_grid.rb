require 'minitest/autorun'
require 'minitest/pride'

require './grid'

# test the crossword grid class
class GridTest < Minitest::Test
  def setup
    @loader = PuzzleLoader.new('Puzzles/2014-4-22-LosAngelesTimes.puz')
    @grid   = Grid.new(@loader.rows, @loader.clues)
  end

  def test_width
    assert_equal @loader.width, @grid.width
  end

  def test_height
    assert_equal @loader.height, @grid.height
  end

  def test_size_width
    assert_equal @loader.width * Constants::CELL_SIZE.width, @grid.size.width
    assert_equal 420, @grid.size.width
  end

  def test_size_height
    assert_equal @loader.height * Constants::CELL_SIZE.width, @grid.size.height
    assert_equal 420, @grid.size.height
  end

  def test_cell_at
  end
end
