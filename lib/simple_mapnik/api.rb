require 'open-uri'
require 'zip'

module SimpleMapnik
  module Api
    class << self
      def install(url, output_dir = './')
        zip_path = "#{output_dir}mapnik_api.zip"
        api_dir = "#{output_dir}mapnik-c-api-master"
        download(url, zip_path)
        unzip(zip_path, output_dir)
        build(api_dir)
        clean([zip_path, api_dir])
      end

      private

      def download(url, output)
        open(url) do |io|
          IO.copy_stream(io, output)
        end
      end

      def clean(items)
        items.each do |item|
          FileUtils.remove_dir(item) if Dir.exist?(item)
          File.delete(item) if File.exist?(item)
        end
      end

      # Unzips an archive in a specific location
      # From this gist: https://gist.github.com/Amitesh/1247229
      def unzip(file, destination)
        Zip::File.open(file) do |zip_file|
          zip_file.each do |f|
            f_path = File.join(destination, f.name)
            FileUtils.mkdir_p(File.dirname(f_path))
            zip_file.extract(f, f_path) unless File.exist?(f_path)
          end
        end
      end

      def build(path)
        system("make -C #{path} && mv #{path}/$(ls #{path}/ | grep -E '(.dylib|.so)') .")
      end
    end
  end
end
