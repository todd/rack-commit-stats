module RackCommitStats
  class CommitFromEnv < Commit
    def branch
      @_branch ||= File.open('BRANCH', 'r').read.gsub /[\r\n]/, ''
    end

    def revision
      @_revision ||= File.open('REVISION', 'r').read.gsub /[\r\n]/, ''
    end

    private

    def commit
      @_commit ||= repo.lookup(revision)
    end
  end
end
