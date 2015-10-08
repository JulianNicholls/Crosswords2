require 'minitest/autorun'
require 'minitest/pride'

require './cell'

class DebugCell < Grid::Cell
  attr_reader :number
end

# Test class for cells
class CellTest < Minitest::Test
  def setup
    @cell_s     = Grid::Cell.new('S')
    @cell_blank = Grid::Cell.new('.') # Black square
  end

  def test_letter
    assert_equal 'S', @cell_s.letter
    assert_equal '.', @cell_blank.letter # Not strictly relevant
  end

  def test_user
    assert_equal '', @cell_s.user
    assert_equal '', @cell_blank.user # Not strictly relevant
  end

  # Blank means black square
  def test_blank
    assert_equal false, @cell_s.blank?
    assert_equal true, @cell_blank.blank?
  end

  # Empty means not filled in by user
  def test_empty
    assert_equal true, @cell_s.empty?
    assert_equal true, @cell_blank.empty? # Not strictly relevant
  end

  def test_set_user
    assert_equal '', @cell_s.user
    @cell_s.user = 'S'
    assert_equal 'S', @cell_s.user
  end

  def test_error_false
    @cell_s.user = 'S'
    assert_equal false, @cell_s.error
  end

  def test_error_true
    @cell_s.user = 'T'
    assert_equal true, @cell_s.error
  end

  def test_add_index
    @dbg_cell = DebugCell.new('Q')
    assert 0, @dbg_cell.number

    @dbg_cell.add_index(3)
    assert 3, @dbg_cell.number
  end

  def test_to_text
    assert 'S,,0', @cell_s.to_text
    assert '.,,0', @cell_blank.to_text
  end

  def test_from_text_empty
    new_cell = DebugCell.from_text('R,,0')

    assert_equal 'R', new_cell.letter
    assert_equal false, new_cell.blank?
    assert_equal true, new_cell.empty?
    assert_equal false, new_cell.error
    assert_equal 0, new_cell.number
  end

  def test_from_text_blank
    new_cell = DebugCell.from_text('.,,0')

    assert_equal '.', new_cell.letter
    assert_equal true, new_cell.blank?
    assert_equal true, new_cell.empty?
    assert_equal false, new_cell.error
    assert_equal 0, new_cell.number
  end

  def test_from_text_numbered
    new_cell = DebugCell.from_text('W,,4')

    assert_equal 'W', new_cell.letter
    assert_equal false, new_cell.blank?
    assert_equal true, new_cell.empty?
    assert_equal false, new_cell.error
    assert_equal 4, new_cell.number
  end

  def test_from_text_filled_correctly
    new_cell = DebugCell.from_text('E,E,3')

    assert_equal 'E', new_cell.letter
    assert_equal false, new_cell.blank?
    assert_equal false, new_cell.empty?
    assert_equal false, new_cell.error
    assert_equal 3, new_cell.number
  end

  def test_from_text_filled_wrongly
    new_cell = DebugCell.from_text('E,A,0')

    assert_equal 'E', new_cell.letter
    assert_equal false, new_cell.blank?
    assert_equal false, new_cell.empty?
    assert_equal true, new_cell.error
    assert_equal 0, new_cell.number
  end
end
