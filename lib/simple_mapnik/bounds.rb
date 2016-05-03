module Mapnik
  class Bounds
    include Mapnik::FFI

    attr_accessor :x_min, :y_min, :x_max, :y_max, :ptr

    def initialize(x_min, y_min, x_max, y_max)
      @x_min = x_min
      @y_min = y_min
      @x_max = x_max
      @y_max = y_max
      ptr = mapnik_bbox x_min, y_min, x_max, y_max
      @ptr = ::FFI::AutoPointer.new ptr, self.class.method(:release)
      @ptr.autorelease = false
    end

    def self.release; end

    def free
      mapnik_bbox_free @ptr
    end
  end
end
