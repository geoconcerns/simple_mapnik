require 'ffi'

module SimpleMapnik
  MAPNIK_BASE = File.join(File.dirname(__FILE__), 'simple_mapnik')

  autoload :Map, File.join(MAPNIK_BASE, 'map')
  autoload :Coordinate, File.join(MAPNIK_BASE, 'coordinate')
  autoload :Bounds, File.join(MAPNIK_BASE, 'bounds')
  autoload :Api, File.join(MAPNIK_BASE, 'api')

  module FFI
    def self.find_lib(lib)
      File.expand_path File.join('.', "#{lib}.#{::FFI::Platform::LIBSUFFIX}")
    end

    def self.mapnik_c_api_path
      find_lib 'libmapnik_c'
    end

    class MAPNIK_COORD_T < ::FFI::Struct
      layout :x, :double,
             :y, :double
    end

    MAPNIK_FUNCTIONS = {
      mapnik_register_datasources: [[:string, :pointer], :int],
      mapnik_register_fonts: [[:string, :pointer], :int],
      mapnik_map: [[:uint, :uint], :pointer],
      mapnik_map_free: [[:pointer], :void],
      # mapnik_map_reset_last_error: [[:pointer], :void],
      mapnik_map_get_srs: [[:pointer], :string],
      mapnik_map_set_srs: [[:pointer, :string], :int],
      mapnik_map_load: [[:pointer, :string], :int],
      mapnik_map_load_string: [[:pointer, :string], :int],
      mapnik_map_zoom_all: [[:pointer], :int],
      mapnik_map_render_to_file: [[:pointer, :string], :int],
      mapnik_map_resize: [[:pointer, :uint, :uint], :void],
      mapnik_map_set_buffer_size: [[:pointer, :int], :void],
      mapnik_map_last_error: [[:pointer], :string],
      mapnik_map_projection: [[:pointer], :pointer], # needs struct
      mapnik_projection_free: [[:pointer], :void],
      mapnik_projection_forward: [[:pointer, MAPNIK_COORD_T.by_value], :pointer],
      mapnik_bbox: [[:double, :double, :double, :double], :pointer],
      mapnik_bbox_free: [[:pointer], :void],
      mapnik_map_zoom_to_box: [[:pointer, :pointer], :void],
      mapnik_image_free: [[:pointer], :void],
      mapnik_map_render_to_image: [[:pointer], :pointer],
      mapnik_image_blob_free: [[:pointer], :void],
      mapnik_image_to_png_blob: [[:pointer], :pointer]
    }.freeze

    extend ::FFI::Library

    def self.attach_functions
      ffi_lib mapnik_c_api_path

      MAPNIK_FUNCTIONS.each do |func, params|
        attach_function func, params.first, params.last
      end
    rescue LoadError, NoMethodError
      raise LoadError.new('Could not load Mapnik library and / or C API')
    end

    attach_functions
  end

  class << self
    def error_ptr
      ::FFI::MemoryPointer.new :char, 65
    end

    def register_datasources(sources)
      SimpleMapnik::FFI.mapnik_register_datasources sources, nil
    end

    def register_fonts(fonts)
      SimpleMapnik::FFI.mapnik_register_fonts fonts, nil
    end
  end
end
