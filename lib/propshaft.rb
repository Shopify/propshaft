# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/module/delegation"
require "logger"

module Propshaft
  singleton_class.attr_accessor :logger
  @logger = Logger.new(STDOUT)
end

require "propshaft/assembly"
require "propshaft/errors"
require "propshaft/helper"
require "propshaft/railtie" if defined?(Rails::Railtie)
