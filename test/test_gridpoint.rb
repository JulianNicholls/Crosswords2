require 'minitest/autorun'
require 'minitest/pride'

require 'gosu_enhanced'
require './grid'
require './gridpoint'

# Test the Grid Point class (row, col)
class GridPointTest < Minitest::Test
  def setup
    @loader = PuzzleLoader.new('Puzzles/2014-4-22-LosAngelesTimes.puz')
    @grid   = Grid.new(@loader.rows, @loader.clues)

    GridPoint.grid = @grid
  end

  def test_out_of_range_left
    assert_equal true, GridPoint.new(0, -1).out_of_range?
    assert_equal true, GridPoint.new(@grid.height - 1, -1).out_of_range?
  end

  def test_out_of_range_right
    assert_equal true, GridPoint.new(0, @grid.width).out_of_range?
    assert_equal true,
                 GridPoint.new(@grid.height - 1, @grid.width).out_of_range?
  end

  def test_out_of_range_top
    assert_equal true, GridPoint.new(-1, 0).out_of_range?
    assert_equal true, GridPoint.new(-1, @grid.width - 1).out_of_range?
  end

  def test_out_of_range_bottom
    assert_equal true,
                 GridPoint.new(@grid.height, @grid.width - 1).out_of_range?
  end

  def test_out_of_range_inside_top
    assert_equal false, GridPoint.new(0, 0).out_of_range?
    assert_equal false, GridPoint.new(0, @grid.width - 1).out_of_range?
  end

  def test_out_of_range_inside_bottom
    assert_equal false, GridPoint.new(@grid.height - 1, 0).out_of_range?
    assert_equal false,
                 GridPoint.new(@grid.height - 1, @grid.width - 1).out_of_range?
  end

  def test_out_of_range_middle_somewhere
    assert_equal false, GridPoint.new(3, 5).out_of_range?
  end

  def test_offset
    assert_equal GridPoint.new(6, 8), GridPoint.new(2, 3).offset(4, 5)
    assert_equal GridPoint.new(8, 11),
                 GridPoint.new(3, 4).offset(GridPoint.new(5, 7))
  end

  def test_to_point_top
    assert_equal GosuEnhanced::Point(610, 10), GridPoint.new(0, 0).to_point
    assert_equal GosuEnhanced::Point(610, 402), GridPoint.new(14, 0).to_point
  end

  def test_to_point_bottom
    assert_equal GosuEnhanced::Point(1002, 10), GridPoint.new(0, 14).to_point
    assert_equal GosuEnhanced::Point(1002, 402), GridPoint.new(14, 14).to_point
  end

  def test_to_point_middle
    assert_equal GosuEnhanced::Point(806, 150), GridPoint.new(5, 7).to_point
    assert_equal GosuEnhanced::Point(946, 290), GridPoint.new(10, 12).to_point
  end

  def test_from_point
    assert_equal GridPoint.new(6, 3),
                 GridPoint.from_point(GosuEnhanced::Point(700, 200))
    assert_equal GridPoint.new(12, 10),
                 GridPoint.from_point(GosuEnhanced::Point(900, 360))
  end

  def test_from_xy
    assert_equal GridPoint.new(6, 3), GridPoint.from_xy(700, 200)
    assert_equal GridPoint.new(12, 10), GridPoint.from_xy(900, 360)
  end
end
