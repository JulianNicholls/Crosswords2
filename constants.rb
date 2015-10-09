require 'gosu_enhanced'

# Constants for the crossword game
module Constants
  extend GosuEnhanced

  MARGIN      = 5

  CELL_SIZE   = Size(28, 28)

  CLUE_COLUMN_WIDTH = 290

  # 620 and 20
  BASE_WIDTH  = MARGIN * 8 + 2 * CLUE_COLUMN_WIDTH
  BASE_HEIGHT = MARGIN * 4

  # (610, 10)
  GRID_ORIGIN = Point(BASE_WIDTH - 2 * MARGIN, MARGIN * 2)

  # 10 and 310
  ACROSS_LEFT = MARGIN * 2
  DOWN_LEFT   = ACROSS_LEFT + MARGIN * 2 + CLUE_COLUMN_WIDTH

  BACKGROUND  = Gosu::Color.new(0xff74410d)   # Brown
  WHITE       = Gosu::Color.new(0xffffffff)
  BLACK       = Gosu::Color.new(0xff000000)
  SHADOW      = Gosu::Color.new(0x80000000)
  HIGHLIGHT   = Gosu::Color.new(0xffe8ffff)   # Liquid Cyan
  CURRENT     = Gosu::Color.new(0xffa8ffff)   # Less Liquid Cyan
  CLUE_LIGHT  = Gosu::Color.new(0xff4d2c09)   # Dark Brown
  ERROR_BK    = Gosu::Color.new(0xffffe0e0)   # Liquid Pink
  ERROR_FG    = Gosu::Color.new(0xffff0000)   # Bold Red

  BK_COLOURS  = { none:     WHITE,
                  word:     HIGHLIGHT,
                  current:  CURRENT,
                  wrong:    ERROR_BK }
end
