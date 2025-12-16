# config/puma.rb

max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
min_threads_count = max_threads_count
threads min_threads_count, max_threads_count

environment ENV.fetch("RAILS_ENV", "development")

workers ENV.fetch("WEB_CONCURRENCY", 1)
preload_app!

if ENV["RAILS_ENV"] == "production"
  bind "unix:///var/www/ecolocal/shared/tmp/sockets/puma.sock"

  pidfile "/var/www/ecolocal/shared/tmp/pids/puma.pid"
  state_path "/var/www/ecolocal/shared/tmp/pids/puma.state"
else
  port ENV.fetch("PORT", 3000)
end

plugin :tmp_restart
