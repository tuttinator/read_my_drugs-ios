# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap/network-indicator'
require 'bubble-wrap/ui'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Read My Drugs'
  app.pods do
    pod 'QRCodeReaderViewController', '~> 2.0.0'
  end
end
