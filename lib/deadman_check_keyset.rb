require 'deadman_check/version'
require 'deadman_check_global'
require 'redis'

module DeadmanCheck
  # KeySet Class
  class KeySet
    attr_accessor :host, :port, :key

    def initialize(host, port, key)
      @host = host
      @port = port
      @key  = key
    end

    def _update_redis_key(host, port, key)
      epoch_time_now = DeadmanCheck::DeadmanCheckGlobal.new.get_epoch_time
      redis = Redis.new(:host => host, :port => port)
      redis.set(key, epoch_time_now)
      puts "Redis key #{key} updated EPOCH to #{epoch_time_now}"
    end

    def run_redis_key_update
      _update_redis_key(@host, @port, @key)
    end
  end
end