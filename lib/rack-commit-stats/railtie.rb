module RackCommitStats
  class Railtie < Rails::Railtie
    config.rack_commit_stats = ActiveSupport::OrderedOptions.new

    initializer "rack-commit-stats.configure" do |app|
      RackCommitStats.configure do |config|
        config.repo_path = app.config.rack_commit_stats.repo_path ||
          DEFAULT_REPO_PATH
      end
    end
  end
end
