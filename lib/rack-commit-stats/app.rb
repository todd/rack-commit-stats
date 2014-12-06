require 'json'

module RackCommitStats
  class App
    def call(env)
      status = 200
      headers = {"Content-Type" => "application/json"}

      [status, headers, [response]]
    end

    private

    def response
      {
        branch: commit.branch,
        commit: {
          revision: commit.revision,
          message:  commit.message,
          author:   commit.author
        }
      }.to_json
    end

    def commit
      @_commit ||= Commit.new
    end
  end
end
