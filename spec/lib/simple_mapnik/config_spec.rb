require 'spec_helper'

describe SimpleMapnik::Config do
  subject { described_class.new('shapefile') }

  describe '#xml' do
    it 'has layer rules' do
      config = subject.xml
      expect(config).to include('MarkersSymbolizer')
      expect(config).to include('PolygonSymbolizer')
      expect(config).to include('LineSymbolizer')
      expect(config).to include('+init=epsg:4326')
      expect(config).to include('shape')
    end
  end
end
