#! /usr/bin/env ruby -I.

require 'puzloader'

filename = ARGV[0] || 'Puzzles/2014-4-22-LosAngelesTimes.puz'
loader = PuzzleLoader.new(filename, :debug)
