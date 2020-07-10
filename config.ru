
$:.unshift File.expand_path('..', __FILE__)


require 'app'

root_dir = File.join(File.dirname(__FILE__))
set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir
set :app_file,    File.join(File.expand_path('..',__FILE__), 'app.rb')
set :bind,        '0.0.0.0'
disable :run

run Sinatra::Application
