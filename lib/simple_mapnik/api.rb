require 'open-uri'
require 'zip'

module SimpleMapnik
  class Api
    attr_accessor :output_dir
    attr_writer :lib, :url, :src_directory_name

    def initialize(output_dir = './')
      @output_dir = output_dir
    end

    def check_and_install
      lib_exist = File.exist? File.expand_path(File.join(output_dir, lib))
      install unless lib_exist
    end

    def install
      download
      unzip
      build
      clean
    end

    def lib
      @lib ||= "libmapnik_c.#{::FFI::Platform::LIBSUFFIX}"
    end

    def url
      @url ||= 'https://github.com/geoconcerns/mapnik-c-api/archive/v0.0.2.zip'
    end

    def src_directory_name
      @src_directory_name ||= 'mapnik-c-api-0.0.2'
    end

    protected

    def zip_path
      File.expand_path(File.join(output_dir, 'mapnik_api.zip'))
    end

    def source_directory
      File.expand_path(File.join(output_dir, src_directory_name))
    end

    def download
      open(url) do |io|
        IO.copy_stream(io, zip_path)
      end
    end

    def unzip
      Zip::File.open(zip_path) do |zip_file|
        zip_file.each do |f|
          f_path = File.join(output_dir, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
      end
    end

    def build
      path = source_directory
      system("make -C #{path} && mv #{path}/$(ls #{path}/ | grep -E '(.dylib|.so)') #{output_dir}.")
    end

    def clean
      [zip_path, source_directory].each do |item|
        FileUtils.remove_dir(item) if Dir.exist?(item)
        File.delete(item) if File.exist?(item)
      end
    end
  end
end
