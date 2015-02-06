worker_processes 4

WORK_DIR=File.absolute_path(File.dirname(__FILE__) + "/..")

working_directory WORK_DIR

preload_app true

timeout 30

listen "localhost:8000"

pid "/tmp/redmine_unicorn.pid"

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
      defined?(ActiveRecord::Base) and
              ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
      defined?(ActiveRecord::Base) and
              ActiveRecord::Base.establish_connection
end
