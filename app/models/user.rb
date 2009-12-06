require_dependency 'status'

class User
  def initialize(options = {})
    @record ||= options[:record]
    if @record
      @name = record.screen_name
    else
      @name = options[:name]
    end
    raise ArgumentError.new("Name not given") unless @name
  end

  # Delegate everything to the TwitterStruct
  def method_missing(sym, *args)
    record.__send__(sym, *args)
  end

  def statuses
    @statuses ||= Rails.cache.fetch("#{cache_key}/statuses", :expires_in => 10.minutes) do
      twitter_client.statuses.user_timeline?(:screen_name => name).map do |status_record|
        Status.new(:record => status_record, :user => self)
      end
    end
  end

  def record
    @record ||= Rails.cache.fetch("#{cache_key}/record", :expires_in => 10.minutes) do
      twitter_client.users.show? :screen_name => name
    end
  end
  
  def name
    @name ||= record.screen_name
  end
  
  def cache_key
    "users/#{name}"
  end

  private
  
  def twitter_client
    @@twitter_client ||= Grackle::Client.new
  end

end
