require 'spec_helper'

describe SimpleMapnik::Coordinate do
  subject { described_class.new(-100, 100) }

  context 'with initial x y values' do
    it 'returns a memory pointer' do
      expect(subject.ptr).to be_a(FFI::MemoryPointer)
    end
  end
end
