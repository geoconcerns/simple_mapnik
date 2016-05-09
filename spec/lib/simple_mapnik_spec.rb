require 'spec_helper'

describe SimpleMapnik do
  describe '#error_ptr' do
    it 'returns an error pointer' do
      expect(described_class.error_ptr).to be_a(FFI::MemoryPointer)
    end
  end

  describe '#register_fonts' do
    let(:fonts) { double }
    it 'calls mapnik_register_fonts method' do
      expect(SimpleMapnik::FFI).to receive(:mapnik_register_fonts)
      described_class.register_fonts(fonts)
    end
  end

  context 'with no mapnik c api library' do
    it 'raises a load error' do
      allow(SimpleMapnik::FFI).to receive(:mapnik_c_api_path).and_return(nil)
      expect { SimpleMapnik::FFI.attach_functions }.to raise_error(LoadError)
    end
  end
end
