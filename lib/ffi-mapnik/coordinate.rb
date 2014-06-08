module Mapnik
  class Coordinate
    include Mapnik::FFI

    attr_accessor :x, :y, :ptr

    def initialize(x, y)
      @x = x
      @y = y
      coord_struct = MAPNIK_COORD_T.new
      coord_struct[:x] = x
      coord_struct[:y] = y
      @ptr = coord_struct.to_ptr
    end
  end
end

