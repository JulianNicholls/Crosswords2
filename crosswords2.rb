#! /usr/bin/env ruby -I.

require 'gosu_enhanced'

require 'constants'
require 'puzloader'
require 'grid'

# Crossword presenter
# :reek:UncommunicativeModuleName  - I think it's OK
class Crosswords2 < Gosu::Window
  include Constants

  def initialize(filename)
    loader = PuzzleLoader(filename)
    super(BASE_WIDTH + loader.rows[0].size * 28, BASE_HEIGHT + loader.rows.size * 28)

    self.caption = 'Ankh ...'
  end

  def needs_cursor?
    true
  end

  # :reek:ControlParameter - No choice
  def button_down(btn_id)
    close if btn_id == Gosu::KbEscape
  end

  private

  def shift_pressed?
    button_down?(Gosu::KbLeftShift) || button_down?(Gosu::KbRightShift)
  end
end

#----------------------------------------------------------------------------
filename = ARGV[0] || 'Puzzles/2014-4-22-LosAngelesTimes.puz'

Crosswords2.new(filename).show
