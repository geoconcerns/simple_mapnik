require 'spec_helper'

describe SimpleMapnik::Map do
  let(:datasources) { '/usr/local/lib/mapnik/input' }
  let(:stylesheet) { './spec/fixtures/sample/stylesheet.xml' }
  let(:out_file) { './tmp/test.png' }

  subject { described_class.new(256, 256) }

  before do
    SimpleMapnik.register_datasources '/usr/local/lib/mapnik/input'
  end

  after(:each) do
    File.delete(out_file) if File.exist? out_file
  end

  context 'with an xml stylesheet' do
    it 'renders a shapefile into an image' do
      subject.load(stylesheet)
      subject.zoom_all
      expect { subject.to_file(out_file) }
        .to change { File.exist?(out_file) }
        .from(false).to(true)
    end
  end

  describe '#zoom_to' do
    let(:bounds) { double }
    let(:ptr) { double }
    it 'calls mapnik_map_zoom_to_box method' do
      allow(bounds).to receive(:ptr).and_return(ptr)
      expect(subject).to receive(:mapnik_map_zoom_to_box)
      subject.zoom_to(bounds)
    end
  end

  describe '#to_image' do
    it 'calls mapnik_map_render_to_image method' do
      expect(subject).to receive(:mapnik_map_render_to_image)
      subject.to_image
    end
  end

  describe '#to_png' do
    it 'calls mapnik_image_to_png_blob method' do
      expect(subject).to receive(:mapnik_image_to_png_blob)
      subject.to_png
    end
  end

  describe '#free' do
    it 'calls mapnik_map_free method' do
      expect(subject).to receive(:mapnik_map_free)
      subject.free
    end
  end
end
