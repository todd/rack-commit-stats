module DeployInfo
  class Railtie < Rails::Railtie
    config.deploy_info = ActiveSupport::OrderedOptions.new

    initializer "deploy-info.configure" do |app|
      DeployInfo.configure do |config|
        config.repo_path = app.config.deploy_info.repo_path || DEFAULT_REPO_PATH
      end
    end
  end
end
