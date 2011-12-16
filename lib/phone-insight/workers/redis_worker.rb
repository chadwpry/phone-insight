require "simple_worker"
require "uri"

class RedisWorker < SimpleWorker::Base
  merge_gem "redis"

  attr_accessor :redis_connection

  def run
    log "\nRunning RedisWorker..."
 
    # For parsing URL's from Redis to Go
    # This will be modified to include an input for "raw" connection data
    url = URI.parse(@redis_connection)
    
    log "\nConnecting to Redis..."
    redis = Redis.new(:host => url.host, :port => url.port, :password => url.password)
    log "Connected.\n\n"

    # Basic operations, although you can do any Redis command here you want

    # SET
    result = redis.set("price:type", "fresh")
    log "Set op for \"prince:type\" returned #{result}"

    # GET
    result = redis.get("prince:type")
    log "Set op for \"prince:type\" returned #{result}"

    # DELETE
    result = redis.del("prince:type")
    log "Del op for \"prince:type\" returned #{result}"
    
    log "\nFinished processing RedisWorker.\n\n"
  end
end
