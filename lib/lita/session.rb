require "ohm"
require "redic"

require "lita/session/version"
require "lita/session/configuration"
require "lita/session/session_object"

module Lita
  module Session
    attr_reader :configuration

		def self.configure &block
			default = Configuration.new
			default.ohm.redis.host = ENV["OHM_REDIS_HOST"] || "127.0.0.1",
			default.ohm.redis.port = ENV["OHM_REDIS_PORT"] || 6379

			block.call(default) if block_given?

			Ohm.redis = Redic.new(
				ENV["OHM_REDIS_URL"] || "redis://#{default.ohm.redis.host}:#{default.ohm.redis.port}"
			)
		end

		def self.configuration
			@configuration ||= Configuration.new
		end
  end
end
