require 'json'

module RackCommitStats
  class App
    class << self

      # Public: call method for Rack. The response body is a JSON object
      # representing the current Commit.
      #
      # env - The request environment.
      #
      # Returns an array of response data for Rack.
      def call(env)
        status  = 200
        headers = {"Content-Type" => "application/json"}

        [status, headers, [response]]
      end

      # Internal: Builds a hash of commit data and serializes it to JSON.
      #
      # Returns a JSON String of commit data.
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

      # Internal: Getter for Commit or CommitFromEnv.
      #
      # Returns a CommitFromEnv object if the app is operating in
      # file mode, a Commit object otherwise.
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
