namespace :rack_commit_stats do
  desc "Creates a BRANCH file in the project root"
  task :create_branch_file do
    on roles(:app) do
      within release_path do
        branch = fetch(:branch)

        execute :echo, "#{branch} >> BRANCH"
      end
    end
  end
end
