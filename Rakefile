require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "lita/session"

RSpec::Core::RakeTask.new(:spec)

task :default do
	Lita::Session.configure do |config|
		config.ohm.redis.host = "127.0.0.1",
		config.ohm.redis.port = 6379
	end

	include Lita::Session::SessionObject
	sess = session(231321, create: true)
	sess["token"] = "123"
	sess["token2"] = "234"
	sess = session(231321)
	sess["token"] = "51442"
	puts sess["token"]
	sess.destroy
end
