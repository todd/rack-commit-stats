module RackCommitStats
  class CommitFromEnv < Commit
    REVISION_LOG_FILE = 'revisions.log'

    # Public: Gets the current branch name.
    #
    # Returns a branch name String.
    def branch
      current_revision[1]
    end

    # Public: Gets the current revision.
    #
    # Returns a revision String.
    def revision
      commit.oid
    end

    private

    # Private: Get's the current commit from a Capistrano deployment log.
    def commit
      @_commit ||= repo.lookup(sha_from_file)
    end

    # Private: Get's the current SHA from a Capistrano deployment log.
    def sha_from_file
      current_revision[3].gsub(/[)]/, '')
    end

    # Private: Gets the current revision from a Capistrano deployment log.
    def current_revision
      @_current_revision ||= File.open(
        File.join(
          RackCommitStats.config.file_path_prefix, REVISION_LOG_FILE
        ), 'r'
      ).readlines.last.split
    end
  end
end
