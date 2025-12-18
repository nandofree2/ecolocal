namespace :deploy do
  desc 'Upload config/master.key to shared path if missing'
  task :upload_master_key do
    on roles(:app) do
      shared_config = File.join(shared_path, 'config')
      remote_key = File.join(shared_config, 'master.key')

      execute :mkdir, '-p', shared_config

      if test("[ -f #{remote_key} ]")
        info "master.key already present on server at #{remote_key}, skipping upload"
      else
        upload! 'config/master.key', remote_key
        execute :chmod, '600', remote_key
        info "Uploaded local config/master.key to #{remote_key}"
      end
    end
  end

  # Ensure the key is present before Capistrano checks linked files
  before 'deploy:check:linked_files', 'deploy:upload_master_key'
end
