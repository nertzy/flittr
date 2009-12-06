require_dependency 'status'

class User
  def initialize(options = {})
    @record ||= options[:record]
    if @record
      @screen_name = record.screen_name
    else
      @screen_name = options[:screen_name]
    end
    raise ArgumentError.new("Screen name not given") unless @screen_name
    raise NotAuthorized if record.protected
  end

  # Delegate everything to the TwitterStruct
  def method_missing(sym, *args)
    record.__send__(sym, *args)
  end

  def statuses
    @statuses ||= Rails.cache.fetch("#{cache_key}/statuses", :expires_in => 10.minutes) do
      twitter_client.statuses.user_timeline?(:screen_name => screen_name).map do |status_record|
        Status.new(:record => status_record, :user => self)
      end
    end
  end

  def record
    @record ||= Rails.cache.fetch("#{cache_key}/record", :expires_in => 10.minutes) do
      twitter_client.users.show? :screen_name => screen_name
    end
  end
  
  def screen_name
    @screen_name ||= formatted_screen_name
  end
  
  def formatted_screen_name
    record.screen_name
  end
  
  def cache_key
    "users/#{screen_name}"
  end

  private
  
  def twitter_client
    @@twitter_client ||= Grackle::Client.new
  end

  class NotAuthorized < StandardError; end

end
