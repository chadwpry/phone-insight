require "simple_worker"
require "yaml"

require_relative "redis_worker"

SIMPLE_WORKER_CONFIG = {}
begin
  SIMPLE_WORKER_CONFIG.merge!(YAML.load_file("../../../config/simple_worker.yml"))
rescue
  SIMPLE_WORKER_CONFIG.merge!({
    "project_id" => ENV['SIMPLE_WORKER_PROJECT_ID'],
    "token" => ENV['SIMPLE_WORKER_TOKEN'],
  })
end

SimpleWorker.configure do |config|
  config.project_id = SIMPLE_WORKER_CONFIG["project_id"]
  config.token = SIMPLE_WORKER_CONFIG["token"]
  puts config.project_id
end

puts SIMPLE_WORKER_CONFIG.inspect


REDIS_CONFIG = {}
begin
  REDIS_CONFIG.merge!(YAML.load_file("../../../config/redis.yml"))
rescue
  REDIS_CONFIG.merge!({
    "redis_uri" => ENV["REDISTOGO_URL"]
  })
end

puts REDIS_CONFIG.inspect

worker = RedisWorker.new
worker.redis_connection = REDIS_CONFIG["redis_uri"]

#worker.run_local

worker.queue
#worker.wait_until_complete
#puts worker.log
