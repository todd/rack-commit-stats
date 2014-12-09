module RackCommitStats
  class Railtie < Rails::Railtie
    config.rack_commit_stats = ActiveSupport::OrderedOptions.new

    initializer "rack-commit-stats.configure" do |app|
      RackCommitStats.configure do |config|
        config.repo_path = app.config.rack_commit_stats.repo_path ||
          DEFAULT_REPO_PATH

        config.mode = app.config.rack_commit_stats.mode || DEFAULT_MODE
        config.file_path_prefix = app.config.rack_commit_stats.file_path_prefix ||
          DEFAULT_FILE_PATH_PREFIX
      end
    end
  end
end
