module RackCommitStats
  require 'rack-commit-stats/app'
  require 'rack-commit-stats/commit'
  require 'rack-commit-stats/commit_from_env'
  require 'rack-commit-stats/railtie' if defined? Rails

  DEFAULT_REPO_PATH        = '.git'
  DEFAULT_MODE             = :default
  FILE_MODE                = :file
  DEFAULT_FILE_PATH_PREFIX = '.'

  class Configuration < Struct.new(:repo_path, :mode, :file_path_prefix)
    def file_mode?
      mode == FILE_MODE
    end
  end

  def self.config
    @@_config ||= Configuration.new(
      DEFAULT_REPO_PATH, DEFAULT_MODE, DEFAULT_FILE_PATH_PREFIX
    )
  end

  def self.configure
    yield self.config
  end
end
