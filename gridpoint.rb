require './constants'

# Represent a cell position in the grid in row, column order
GridPoint = Struct.new(:row, :col) do
  extend Constants

  @grid = nil

  class << self
    attr_accessor :grid

    def from_point(pos)
      from_xy(pos.x, pos.y)
    end

    # :reek:UncommunicativeParameterName - x and y are the natural names to use
    def from_xy(x, y)
      new(
        ((y - Constants::GRID_ORIGIN.y) / Constants::CELL_SIZE.height).floor,
        ((x - Constants::GRID_ORIGIN.x) / Constants::CELL_SIZE.width).floor
      )
    end
  end

  def out_of_range?
    row < 0 || col < 0 ||
    row >= grid.height || col >= grid.width
  end

  def offset(dr, dc = nil)
    if dr.respond_to? :row
      GridPoint.new(row + dr.row, col + dr.col)
    else
      GridPoint.new(row + dr, col + dc)
    end
  end

  def to_point
    Constants::GRID_ORIGIN.offset(
      col * Constants::CELL_SIZE.width, row * Constants::CELL_SIZE.height)
  end

  private

  def grid
    self.class.grid
  end
end
