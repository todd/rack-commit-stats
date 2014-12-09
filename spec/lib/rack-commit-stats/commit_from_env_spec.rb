require 'spec_helper'

RSpec.describe RackCommitStats::CommitFromEnv do
  before do
    RackCommitStats.configure do |config|
      config.repo_path = 'spec/fixtures/repo'
      config.mode = :file
      config.file_path_prefix = 'spec/fixtures'
    end
  end

  describe '#branch' do
    it 'returns the branch name at HEAD' do
      expect(described_class.new.branch).to eq 'test_branch'
    end
  end

  describe '#revision' do
    it 'returns the revision SHA at HEAD' do
      expect(described_class.new.revision).to eq(
        "ce7a40f280665ce2e7bbc10b81a91632affe15ab"
      )
    end
  end

  describe '#message' do
    it 'returns the commit message at HEAD' do
      expect(described_class.new.message).to eq "bar"
    end
  end

  describe '#author' do
    it 'returns a hash of author information for the commit at HEAD' do
      expect(described_class.new.author).to eq(
        {
          name: 'Foo Bar',
          email: 'foo@bar.com'
        }
      )
    end
  end
end
