base = File.dirname(__FILE__)
$:.unshift File.join(base, 'lib')

require 'rubygems'
require 'bundler/setup'
#Bundler.require(:default)

require "phone-insight"

PhoneInsight::Application.set(:root) { base }
run PhoneInsight::Application

