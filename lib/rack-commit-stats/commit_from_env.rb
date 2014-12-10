module RackCommitStats
  class CommitFromEnv < Commit
    REVISION_LOG_FILE = 'revisions.log'

    def branch
      current_revision[1]
    end

    def revision
      commit.oid
    end

    private

    def commit
      @_commit ||= repo.lookup(sha_from_file)
    end

    def sha_from_file
      current_revision[3].gsub(/[)]/, '')
    end

    def current_revision
      @_current_revision ||= File.open(
        File.join(
          RackCommitStats.config.file_path_prefix, REVISION_LOG_FILE
        ), 'r'
      ).readlines.last.split
    end
  end
end
