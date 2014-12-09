require 'spec_helper'

RSpec.describe RackCommitStats::App do
  describe '.call' do
    let(:commit_double)     { instance_double("Commit", commit_properties) }
    let(:commit_properties) {
      {
        branch:   'specs',
        revision: 'gibberish',
        message:  'hello',
        author:   {name: 'Foo Bar', email: 'foo@bar.com'}
      }
    }
    subject { described_class.call env_for("http://foobar.com") }

    it 'returns a 200 status' do
      status, _, _ = subject
      expect(status).to eq 200
    end

    it 'returns headers with a JSON content-type' do
      _, headers, _ = subject
      expect(headers).to eq({"Content-Type" => "application/json"})
    end

    context 'default mode' do
      it 'renders a JSON object with commit details as the body' do
        allow(described_class).to receive(:commit).and_return commit_double
        _, _, response = subject
        expect(response.first).to eq(
          {
            branch: 'specs',
            commit: {
              revision: 'gibberish',
              message:  'hello',
              author: {
                name:  'Foo Bar',
                email: 'foo@bar.com'
              }
            }
          }.to_json
        )
      end
    end

    context 'file mode' do
      before do
        RackCommitStats.configure { |config| config.mode = :file }
      end

      it 'renders a JSON object with commit details as the body' do
        allow(described_class).to receive(:commit).and_return commit_double
        _, _, response = subject
        expect(response.first).to eq(
          {
            branch: 'specs',
            commit: {
              revision: 'gibberish',
              message:  'hello',
              author: {
                name:  'Foo Bar',
                email: 'foo@bar.com'
              }
            }
          }.to_json
        )
      end
    end
  end

  def env_for(url, opts = {})
    Rack::MockRequest.env_for(url, opts)
  end
end
