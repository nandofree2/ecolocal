namespace :puma do
  desc "Ensure puma shared directories exist (sockets, pids)"
  task :make_dirs do
    on roles(:app) do
      shared_tmp = File.join(shared_path, 'tmp')
      sockets = File.join(shared_tmp, 'sockets')
  pids = File.join(shared_tmp, 'pids')
  shared_log = File.join(shared_path, 'log')

      execute :mkdir, "-p", sockets
      execute :mkdir, "-p", pids
  execute :mkdir, "-p", shared_log
  execute :chmod, "u+rwX,g+rwX,o-rwx", shared_tmp
    end
  end

  before 'puma:start', 'puma:make_dirs'
  before 'puma:restart', 'puma:make_dirs'
  before 'deploy:starting', 'puma:make_dirs'
end
