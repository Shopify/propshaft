# frozen_string_literal: true

require "test_helper"

class Propshaft::LoggerTest < ActiveSupport::TestCase
  if defined?(Ractor)
    test "the logger is readable from a non-main Ractor when shareable" do
      old_logger = Propshaft.logger
      shareable_logger = Object.new.freeze
      Propshaft.logger = shareable_logger

      old_experimental, Warning[:experimental] = Warning[:experimental], false
      ractor = Ractor.new { Propshaft.logger }
      value = ractor.respond_to?(:value) ? ractor.value : ractor.take

      assert_same shareable_logger, value
    ensure
      Warning[:experimental] = old_experimental unless old_experimental.nil?
      Propshaft.logger = old_logger
    end
  end
end
