#! /usr/bin/env ruby -I.

require 'puzloader'
require 'grid'

def debug_loader(loader)
  puts "Texts:\n  #{loader.title}\n  #{loader.author}\n  #{loader.copyright}"
  puts "\nDimensions: #{loader.width} x #{loader.height}"
  print "\nRows:\n  ", loader.rows.join("\n  "), "\n"
  print "\nClues:\n  ", loader.clues.join("\n  "), "\n"
end

filename = ARGV[0] || 'Puzzles/2014-4-22-LosAngelesTimes.puz'
loader = PuzzleLoader.new(filename)
debug_loader(loader)

grid = Grid.new(loader.rows, loader.clues)
