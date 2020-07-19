require 'cucumber'
require 'faker'
require 'httparty'
require 'rspec'

CONFIG = YAML.load_file(File.join(Dir.pwd, "configs/#{ENV['ENV_TYPE']}.yml"))