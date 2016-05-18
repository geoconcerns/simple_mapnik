require 'nokogiri'
require 'yaml'

module SimpleMapnik
  class Config
    attr_reader   :settings
    attr_writer   :srs,
                  :type,
                  :background_color,
                  :polygon_fill_color,
                  :line_stroke_color,
                  :line_stroke_width,
                  :marker_fill,
                  :marker_width,
                  :marker_height,
                  :marker_stroke_color,
                  :marker_stroke_width

    def initialize(path)
      @path = path
      @settings ||= File.exist?(config_file) ? YAML.load_file(config_file) : {}
    end

    def config_file
      if defined?(Rails) && Rails.root
        File.join(Rails.root, 'config/mapnik.yml')
      else
        File.expand_path('../../config/mapnik.yml', File.dirname(__FILE__))
      end
    end

    def srs
      @srs ||= '+init=epsg:4326'
    end

    def type
      @type ||= 'shape'
    end

    def background_color
      @background_color ||= settings.fetch('background_color', '#483d8b')
    end

    def polygon_fill_color
      @polygon_fill_color ||= settings.fetch('polygon_fill_color', '#fffff0')
    end

    def line_stroke_color
      @line_stroke_color ||= settings.fetch('line_stroke_color', '#483d8b')
    end

    def line_stroke_width
      @line_stroke_width ||= settings.fetch('line_stroke_width', '0.2')
    end

    def marker_fill
      @marker_fill ||= settings.fetch('marker_fill', '#0000ff')
    end

    def marker_width
      @marker_width ||= settings.fetch('marker_width', '5')
    end

    def marker_height
      @marker_height ||= settings.fetch('marker_height', '5')
    end

    def marker_stroke_color
      @marker_stroke_color ||= settings.fetch('marker_stroke_color', '#483d8b')
    end

    def marker_stroke_width
      @marker_stroke_width ||= settings.fetch('marker_stroke_width', '0.2')
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def xml
      Nokogiri::XML::Builder.new do |xml|
        xml.Map(srs: srs, :'background-color' => background_color) do
          xml.Style(name: 'style') do
            xml.Rule() do
              xml.Filter('[mapnik::geometry_type]=point')
              xml.MarkersSymbolizer(
                fill: marker_fill,
                width: marker_width,
                height: marker_height,
                :'stroke-color' => marker_stroke_color,
                :'stroke-width' => marker_stroke_width,
                :'allow_overlap-overlap' => 'true'
              )
            end
            xml.Rule() do
              xml.PolygonSymbolizer(fill: polygon_fill_color)
              xml.LineSymbolizer(
                stroke: line_stroke_color,
                :'stroke-width' => line_stroke_width)
            end
          end
          xml.Layer(name: 'layer', srs: srs) do
            xml.StyleName 'style'
            xml.Datasource do
              xml.Parameter(@path, name: 'file')
              xml.Parameter(type, name: 'type')
            end
          end
        end
      end.to_xml
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
    end
  end
end
