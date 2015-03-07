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

    # Public: Determines whether RackCommitStats should operate in file mode.
    #
    # Returns true if the application is operating in file mode, false
    # otherwise.
    def file_mode?
      mode == FILE_MODE
    end
  end

  # Public: Getter for app Configuration.
  def self.config
    @@_config ||= Configuration.new(
      DEFAULT_REPO_PATH, DEFAULT_MODE, DEFAULT_FILE_PATH_PREFIX
    )
  end

  # Public: Setter for app Configuration.
  def self.configure
    yield self.config
  end
end
