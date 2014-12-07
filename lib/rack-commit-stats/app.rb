require 'json'

module RackCommitStats
  class App
    def self.call(env)
      status = 200
      headers = {"Content-Type" => "application/json"}

      [status, headers, [response]]
    end

    private

    def self.response
      commit = Commit.new

      {
        branch: commit.branch,
        commit: {
          revision: commit.revision,
          message:  commit.message,
          author:   commit.author
        }
      }.to_json
    end
  end
end
