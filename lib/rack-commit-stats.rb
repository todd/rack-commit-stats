module RackCommitStats
  require 'rack-commit-stats/app'
  require 'rack-commit-stats/commit'
  require 'rack-commit-stats/railtie' if defined? Rails

  DEFAULT_REPO_PATH = '.git'

  class Configuration < Struct.new(:repo_path); end

  def self.config
    @@_config ||= Configuration.new(DEFAULT_REPO_PATH)
  end

  def self.configure
    yield self.config
  end
end