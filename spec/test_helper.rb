ENV['RACK_ENV'] = 'test'
require_relative '../app.rb'

require 'minitest/autorun'
require 'rack/test'