require 'minitest/autorun'
require 'minitest/pride'

require './grid'
require './gridpoint'

# Test the Grid Point class (row, col)
class GridPointTest < Minitest::Test
  def setup
    @loader = PuzzleLoader.new('Puzzles/2014-4-22-LosAngelesTimes.puz')
    @grid  = Grid.new(@loader.rows, @loader.clues)
    GridPoint.grid = @grid
  end

  def test_out_of_range_left
    assert_equal true, GridPoint.new(0, -1).out_of_range?
  end

  def test_out_of_range_right
    assert_equal true, GridPoint.new(0, @grid.width).out_of_range?
  end

  def test_out_of_range_top
    assert_equal true, GridPoint.new(-1, 0).out_of_range?
  end

  def test_out_of_range_bottom
    assert_equal true, GridPoint.new(@grid.height, 0).out_of_range?
  end

  def test_out_of_range_inside_corners
    assert_equal false, GridPoint.new(0, 0).out_of_range?
    assert_equal false, GridPoint.new(0, @grid.width - 1).out_of_range?
    assert_equal false, GridPoint.new(@grid.height - 1, 0).out_of_range?
    assert_equal false, GridPoint.new(@grid.height - 1, @grid.width - 1).out_of_range?
  end

  def test_out_of_range_middle_somewhere
    assert_equal false, GridPoint.new(3, 5).out_of_range?
  end

  def test_offset
    assert_equal GridPoint.new(6, 8), GridPoint.new(2, 3).offset(4, 5)
    assert_equal GridPoint.new(8, 11), GridPoint.new(3, 4).offset(GridPoint.new(5, 7))
  end
end
