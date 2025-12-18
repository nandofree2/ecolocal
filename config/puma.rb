# config/puma.rb

threads 2, 2

environment ENV.fetch("RAILS_ENV", "development")

workers 0

silence_single_worker_warning

preload_app!
stdout_redirect "/var/www/ecolocal/shared/log/puma.stdout.log", "/var/www/ecolocal/shared/log/puma.stderr.log", true

if ENV["RAILS_ENV"] == "production"
  bind "unix:///var/www/ecolocal/shared/tmp/sockets/puma.sock"
  chmod_socket = 0660

  pidfile "/var/www/ecolocal/shared/tmp/pids/puma.pid"
  state_path "/var/www/ecolocal/shared/tmp/pids/puma.state"
else
  port ENV.fetch("PORT", 3000)
end

plugin :tmp_restart
