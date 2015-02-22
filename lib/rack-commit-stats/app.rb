require 'json'

module RackCommitStats
  class App
    class << self
      def call(env)
        status  = 200
        headers = {"Content-Type" => "application/json"}

        [status, headers, [response]]
      end

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
        if RackCommitStats.config.file_mode?
          @_commit ||= CommitFromEnv.new
        else
          @_commit ||= Commit.new
        end

        @_commit
      end
    end
  end
end
