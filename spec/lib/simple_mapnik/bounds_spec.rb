require 'spec_helper'

describe SimpleMapnik::Bounds do
  subject { described_class.new(-180, -90, 180, 90) }

  context 'with initial bounding values' do
    it 'returns an auto pointer' do
      expect(subject.ptr).to be_a(FFI::AutoPointer)
    end
  end

  describe '#free' do
    it 'calls mapnik_map_free method' do
      expect(subject).to receive(:mapnik_bbox_free)
      subject.free
    end
  end
end
