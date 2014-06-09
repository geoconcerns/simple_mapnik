module Mapnik
  class Map
    include Mapnik::FFI

    attr_accessor :width, :height, :ptr

    def initialize(width, height)
      @width = width
      @height = height
      ptr = mapnik_map width, height
      @ptr = ::FFI::AutoPointer.new ptr, self.class.method(:release)
      @ptr.autorelease = false
    end

    def self.release;end

    def free
      mapnik_map_free @ptr
    end

    def load(style)
      style = File.expand_path style
      mapnik_map_load @ptr, style
    end

    def zoom_all
      mapnik_map_zoom_all @ptr
    end

    def zoom_to(bounds)
      mapnik_map_zoom_to_box @ptr, bounds.ptr
    end

    def to_image
      mapnik_map_render_to_image @ptr
    end

    def to_png
      mapnik_image_to_png_blob to_image
    end

    def to_file(file)
      file = File.expand_path file
      mapnik_map_render_to_file @ptr, file
    end
  end
end

