namespace :unicorn do
  desc 'Start unicorn'
  task :start do
    config_path = Rails.root.join "config/unicorn.rb"
    sh "bundle exec foreman run unicorn_rails -c #{config_path} -p 8080 -D"
  end

  desc 'Stop unicorn'
  task :stop do
    unicorn_signal(:INT)
  end

  desc 'Restart unicorn'
  task :restart do
    Rake::Task['unicorn:stop'].invoke
    Rake::Task['unicorn:start'].invoke
  end

  desc 'Unicorn pstree (depends on pstree command)'
  task :pstree  do
    sh "pstree '#{unicorn_pid}'"
  end
end

# Helpers
def unicorn_signal(signal)
  Process.kill signal, unicorn_pid
end

def unicorn_pid
  File.read(Rails.root.join('tmp/pids/unicorn.pid')).to_i
rescue Errno::ENOENT
  raise 'Unicorn does not seem to be running'
end
