require 'pp'
require 'forwardable'

require './puzbuffer'

# Loader for a .puz file.
class PuzzleLoader
  extend Forwardable

  SIGNATURE = 'ACROSS&DOWN'

  def_delegators :@buffer, :unpack, :unpack_multiple, :unpack_zstring,
                 :seek_by, :seek_to

  attr_reader :width, :height, :rows, :num_clues, :clues, :title, :author,
              :copyright

  def initialize(filename)
    @buffer = PuzzleBuffer.new(read filename)

    # Skip past an optional pre-header
    seek_to(SIGNATURE, -2)

    # Skip unimportant header fields
    seek_by(2 + 12 + 2 + 4 + 4 + 4 + 2 + 2 + 12)

    load_common
  end

  def scrambled?
    @scrambled != 0
  end

  def valid?
    load_check_values unless @file_checkum
    cksum = @buffer.checksum(0x2C, 8, 0)
    return false if cksum != @cib_checksum

    true
  end

  private

  def load_common
    load_size
    load_answer
    skip_solution
    load_info
    load_clues
  end

  def load_size
    @width, @height, @num_clues = unpack_multiple('C2S<', 4)
    # Puzzle Type, 1 = Normal, 0x0401 = Diagramless
    seek_by(2)
    @scrambled = unpack('S<')
  end

  def load_answer
    @rows = []
    @height.times { @rows << unpack('a' + @width.to_s, @width) }
  end

  # Skip possible solution
  def skip_solution
    seek_by(@width * @height)
  end

  def load_info
    @title      = unpack_zstring
    @author     = unpack_zstring
    @copyright  = unpack_zstring
  end

  def load_clues
    @clues = []
    @num_clues.times { @clues << unpack_zstring }
  end

  def read(filename)
    data = ''

    open(filename, 'rb') do |file|
      data = file.read
    end

    data
  end

  def debug(name, value)
    printf "%s: %d 0x%04x\n", name, value, value
  end
end

# Debg version of puzzle loader that shows more of the header
# :reek:TooManyInstanceVariables - More than half are only used for debugging.
class DebugPuzzleLoader
  def initialize(filename)
    @buffer = PuzzleBuffer.new(read filename)

    # Skip past an optional pre-header
    seek_to(SIGNATURE, -2)

    load_check_values
    show_check_values

    load_common
  end

  # :reek:TooManyStatements
  # :reek:UncommunicativeVariableName - I think they're fine
  def load_check_values
    seek_to(SIGNATURE, -2)

    @file_checksum  = unpack('S<')
    @sig            = unpack_zstring
    @cib_checksum   = unpack('S<')
    @lowparts       = unpack_multiple('C4', 4)
    @highparts      = unpack_multiple('C4', 4)
    @version        = unpack('Z4', 4)
    @reserved1c     = unpack('S<')
    @scrambled_sum  = unpack('S<')
    @reserved20     = unpack_multiple('C12', 12)
  end

  # :reek:TooManyStatements
  def show_check_values
    debug 'File Checksum', @file_checksum
    puts "Signature: #{@sig}"
    debug 'CIB Checksum', @cib_checksum
    pp @lowparts, @highparts
    puts "Version: #{@version}"
    debug 'Reverved?', @reserved1c
    debug 'Scrambled Checksum', @scrambled_checksum || 0
    pp @reserved20
  end
end
