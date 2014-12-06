require 'rugged'

module DeployInfo
  class Deployment
    attr_accessor :repo_path

    DEFAULT_REPO_PATH = '.'

    def initialize(options = {})
      @repo_path = options[:repo_path] || DEFAULT_REPO_PATH
    end

    def branch
      head.name.split('/').last
    end

    def revision
      head.target_id
    end

    def message
      commit.message
    end

    def author
      commit.author.reject { |k, _| k == :time }
    end

    private

    def repo
      @_repo ||= Rugged::Repository.new(repo_path)
    end

    def head
      repo.head
    end

    def commit
      head.target
    end
  end
end
