module RackCommitStats
  class CommitFromEnv < Commit
    def branch
      @_branch ||= File.open(
        File.join(RackCommitStats.config.file_path_prefix, 'BRANCH'), 'r'
      ).read.gsub /[\r\n]/, ''
    end

    def revision
      commit.oid
    end

    private

    def commit
      @_commit ||= repo.lookup(sha_from_file)
    end

    def sha_from_file
      @_sha ||= File.open(
        File.join(RackCommitStats.config.file_path_prefix, 'REVISION'), 'r'
      ).read.gsub /[\r\n]/, ''
    end
  end
end
