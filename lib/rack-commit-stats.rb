module RackCommitStats
  require 'rack-commit-stats/app'
  require 'rack-commit-stats/commit'
  require 'rack-commit-stats/commit_from_env'
  require 'rack-commit-stats/railtie' if defined? Rails

  DEFAULT_REPO_PATH = '.git'
  DEFAULT_MODE      = :default
  CAPISTRANO_MODE   = :capistrano

  class Configuration < Struct.new(:repo_path, :mode)
    def capistrano_mode?
      mode == CAPISTRANO_MODE
    end
  end

  def self.config
    @@_config ||= Configuration.new(DEFAULT_REPO_PATH, DEFAULT_MODE)
  end

  def self.configure
    yield self.config
  end
end
