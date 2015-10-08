# Bufferer for a .puz file, which allows for unpacking values.
class PuzzleBuffer
  SIZES = { 'S' => 2, 'Q' => 8, 'C' => 1 }

  def initialize(data = nil)
    self.data = data
  end

  def data=(data)
    @data   = data
    @length = data.size
    @pos    = 0
  end

  def seek_by(off)
    @pos += off
  end

  def seek_to(text, offset = 0)
    @pos = @data.index(text) + offset
  end

  def unpack_zstring
    str = @data[@pos..-1].unpack('Z' + remaining.to_s)[0]
    @pos += str.size + 1
    str
  end

  def unpack(spec, size = nil)
    unpack_multiple(spec, size)[0]
  end

  # :reek:ControlParameter - size - it would make no sense to define
  # read_4_bytes, read_12_bytes, etc ad infinitum.
  def unpack_multiple(spec, size)
    start = @pos
    @pos += (size || SIZES[spec[0]])
    @data[start..@pos].unpack(spec)
  end

  private

  def remaining
    @length - @pos
  end
end
