require 'yaml'
require 'pathname'
require 'motto/category'
require 'motto/loader'
require "motto/version"

module Motto
  MOTTOS_DIR = File.join(File.dirname(__FILE__), '..', 'mottos')

  class NotFoundCategory < StandardError; end

  module_function

  def new
    Loader.new
  end
end
