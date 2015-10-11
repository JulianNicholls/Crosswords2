require 'minitest/autorun'
require 'minitest/pride'

require './puzloader'

# Test class for puzzle loading
class LoaderTest < Minitest::Test
  def setup
    @loader = PuzzleLoader.new('Puzzles/2014-4-22-LosAngelesTimes.puz')
  end

  def test_width
    assert_equal 15, @loader.width
  end

  def test_height
    assert_equal 15, @loader.height
  end

  def test_title
    assert_equal 'LA Times, Tue, Apr 22, 2014', @loader.title
  end

  def test_author
    assert_equal 'Gail Grabowski and Bruce Venzke / Ed. Rich Norris',
                 @loader.author
  end

  # This ignores the copyright character at the beginning
  def test_copyright
    assert_equal ' 2014 Tribune Content Agency, LLC', @loader.copyright[1..-1]
  end

  def test_rows
    assert_equal @loader.height, @loader.rows.size
    assert_equal @loader.width, @loader.rows[0].size
  end

  def test_clues
    assert_equal 78, @loader.num_clues
  end
end
