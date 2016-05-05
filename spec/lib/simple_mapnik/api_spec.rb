require 'spec_helper'
require 'byebug'

describe SimpleMapnik::Api do
  let(:output_dir) { './tmp/' }
  let(:lib_path) { File.expand_path(File.join(output_dir, subject.lib)) }

  subject { described_class.new(output_dir) }

  describe '#check_and_install' do
    context 'with an existing mapnik c api library' do
      it 'does not compile and install the library' do
        allow(File).to receive(:exist?).and_return(true)
        expect(subject).to_not receive(:install)
        subject.check_and_install
      end
    end

    context 'without an existing mapnik c api library' do
      after do
        File.delete(lib_path) if File.exist? lib_path
      end
      it 'compiles and installs the library' do
        expect { subject.check_and_install }
          .to change { File.exist?(lib_path) }
          .from(false).to(true)
      end
    end
  end
end
