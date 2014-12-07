require 'spec_helper'

RSpec.describe RackCommitStats do
  describe '.configure' do
    context 'with custom repo path' do
      it 'sets the custom repo path within the configuration' do
        described_class.configure { |config| config.repo_path = 'foo' }
        expect(described_class.config.repo_path).to eq 'foo'
      end
    end

    context 'without custom repo path' do
      it 'sets the default repo path within the configuration' do
        described_class.configure { |config| }
        expect(described_class.config.repo_path).to eq '.git'
      end
    end
  end
end
