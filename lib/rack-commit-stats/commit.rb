require 'rugged'

module RackCommitStats
  class Commit

    # Public: Gets the current branch name.
    #
    # Returns a branch name String.
    def branch
      head.name.split('/').last
    end

    # Public: Gets the current revision.
    #
    # Returns a revision String.
    def revision
      head.target_id
    end

    # Public: Gets the current commit's message.
    #
    # Returns the commit message String.
    def message
      commit.message.gsub /[\r\n]/, ''
    end

    # Public: Gets the current commit's author.
    #
    # Returns the author name String.
    def author
      commit.author.reject { |k, _| k == :time }
    end

    protected

    # Protected: Gets and memoizes a Rugged Repository.
    #
    # Returns a Rugged::Repository instance of the repository.
    def repo
      @_repo ||= Rugged::Repository.new(RackCommitStats.config.repo_path)
    end

    private

    # Private: Gets the repo's HEAD.
    def head
      repo.head
    end

    # Private: Gets the current commit at HEAD.
    def commit
      head.target
    end
  end
end
