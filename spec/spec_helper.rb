$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
MODELS = File.join(File.dirname(__FILE__), "models")
$LOAD_PATH.unshift(MODELS)

require "rubygems"
require "bundler"
Bundler.setup

require 'mongoid'
require 'mongoid/slugs'
require 'rspec'
require 'rspec/core'
require 'rspec/expectations'

Mongoid.configure do |config|
  config.connect_to("mongoid-slugs-test")
end

Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }


RSpec.configure do |config|
  config.include RSpec::Matchers
  config.mock_with :rspec
  config.after :all do
    Mongoid::Config.purge!
  end
end
