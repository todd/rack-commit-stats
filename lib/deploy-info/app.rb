require 'json'

module DeployInfo
  class App
    def call(env)
      status = 200
      headers = {"Content-Type" => "application/json"}

      [status, headers, [response]]
    end

    private

    def response
      {
        branch: deployment.branch,
        commit: {
          revision: deployment.revision,
          message:  deployment.message,
          author:   deployment.author
        }
      }.to_json
    end

    def deployment
      @_deployment ||= Deployment.new
    end
  end
end
