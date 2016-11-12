# paths
app_path = "/home/deployer/chewing-rails"
working_directory "#{app_path}/current"
pid               "#{app_path}/current/tmp/pids/unicorn.pid"

listen "/tmp/unicorn.chewing-rails.sock", backlog: 64

stderr_path "log/unicorn.stderr.log"
stdout_path "log/unicorn.stdout.log"

worker_processes 2

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

# preload
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
  
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end