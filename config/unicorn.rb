worker_processes 1
preload_app true

listen      File.expand_path('tmp/sockets/unicorn.sock', ENV['RAILS_ROOT'])
pid         File.expand_path('tmp/pids/unicorn.pid', ENV['RAILS_ROOT'])

stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
