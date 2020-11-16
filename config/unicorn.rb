APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))

# puts "APP ROOT ->>> #{APP_ROOT}"

if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
  begin
    rvm_path = File.dirname(File.dirname(ENV['MY_RUBY_HOME']))
    # puts "RUBY HOME ->>> #{rvm_path}"
    rvm_lib_path = File.join(rvm_path, 'lib')
    # $LOAD_PATH.unshift rvm_lib_path
    # require 'rvm'
    # RVM.use_from_path! APP_ROOT
  rescue LoadError
    raise "RVM ruby lib is currently unavailable."
  end
end

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'

if ENV['RAILS_ENV'] == 'production'
  worker_processes 2
else
  worker_processes 2
end

working_directory APP_ROOT

preload_app true

timeout 60

listen APP_ROOT + "/tmp/sockets/unicorn.sock", :backlog => 64

pid APP_ROOT + "/tmp/pids/unicorn.pid"

stderr_path APP_ROOT + "/log/unicorn.stderr.log"
stdout_path APP_ROOT + "/log/unicorn.stdout.log"

before_fork do |server, worker|
  # puts "SERVER ->>> #{server}"

  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = APP_ROOT + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # puts "Old master alerady dead"
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV["DB_POOL"] || ENV['RAILS_MAX_THREADS'] || 5

    ActiveRecord::Base.establish_connection(config)
  end
end
