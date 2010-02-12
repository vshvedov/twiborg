require 'rubygems'
require 'daemons'

options = {}

default_pid_dir = File.dirname(__FILE__) + '/pids/'

if File.exists?(default_pid_dir)
  options[:dir_mode] = :normal
  options[:dir] = default_pid_dir
end

Daemons.run(File.dirname(__FILE__) + '/main_daemon.rb', options)
