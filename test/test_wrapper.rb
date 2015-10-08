require 'minitest/autorun'
require 'minitest/pride'

require './clue'

# Test class for Text Wrapping
class Calc555Resistors < Minitest::Test
  def test_simple_two_part
    assert_equal ['Mary had a', 'little lamb'], TextWrapper.wrap("Mary had a little lamb", 2)
  end

  def test_default_two_part
    assert_equal ['Mary had a', 'little lamb'], TextWrapper.wrap("Mary had a little lamb")
  end

  def test_simple_three_part
    assert_equal ['Mary had', 'a little', 'lamb'], TextWrapper.wrap("Mary had a little lamb", 3)
  end

  def test_simple_four_part
    assert_equal ['Mary had a',
                  'little lamb,',
                  'its fleece was',
                  'White as snow'], TextWrapper.wrap(
      "Mary had a little lamb, its fleece was White as snow", 4)
  end

  def test_large_text_into_eight_pieces
    assert_equal ["When run directly, it starts by initializing the panel", # 54
                  "and writing 'SETUP'. Then it waits for the user to hit", # 54
                  "enter between each of the next phases: position the",    # 51
                  "cursor to the beginning of the second line and write",   # 52
                  "'Second Line', then write 'End' at the end of the",      # 49
                  "second line, after which the cursor is shown, hidden,",  # 53
                  "and set blinking before finally waiting for the user",   # 52
                  "to hit enter again and then disconnecting from GPIO."], TextWrapper.wrap( # 51
      "When run directly, it starts by initializing the panel and writing 'SETUP'. Then it waits for the user to hit enter between each of the next phases: position the cursor to the beginning of the second line and write 'Second Line', then write 'End' at the end of the second line, after which the cursor is shown, hidden, and set blinking before finally waiting for the user to hit enter again and then disconnecting from GPIO.", 8)
  end

  def test_right_bias
    assert_equal ['xxxxxx xxxxxx', 'xxxxxx'], TextWrapper.wrap("xxxxxx xxxxxx xxxxxx", 2)
  end
end
