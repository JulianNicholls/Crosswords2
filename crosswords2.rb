#! /usr/bin/env ruby -I.

require 'gosu_enhanced'

require 'constants'
require 'puzloader'
require 'grid'

class Crosswords2 < Gosu::Window
  include Constants

  def initialize(filename)
    super(BASE_WIDTH + 15 * 28, BASE_HEIGHT + 15 * 28)

    self.caption = "Ankh ..."
  end

  def needs_cursor?
    true
  end

  def button_down(btn_id)
    close if btn_id == Gosu::KbEscape
  end

  private

  def shift_pressed?
    button_down?(Gosu::KbLeftShift) || button_down?(Gosu::KbRightShift)
  end
end

filename = ARGV[0] || 'Puzzles/2014-4-22-LosAngelesTimes.puz'

Crosswords2.new(filename).show
