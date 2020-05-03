require 'term_extraction'
require_dependency 'photo'

class Status
  EXTRAS = %w[description url_m url_s url_sq url_t].join(',')

  attr_reader :id

  def initialize(options = {})
    @record ||= options[:record]
    @user ||= options[:user]
    @id = @record ? @record.id : options[:id]
    raise ArgumentError("id not given") unless @id
    record
  end

  # Lazy load the Twitter record
  def record
    @record ||= Rails.cache.fetch("statuses/#{id}") { twitter_client.status(id) }
  end

  # Delegate everything to the TwitterStruct
  def method_missing(sym, *args)
    if record.respond_to?(sym)
      record.__send__(sym, *args)
    else
      super
    end
  end

  def user
    @user ||= User.new(:record => record.user)
  end

  def terms
    term_extraction.terms
  end

  def photo
    Rails.cache.fetch("#{cache_key}/photo") do
      Photo.find_or_create_by!(twitter_status_id: @id) do |photo|
        photo.flickr = flickr_photo if photo.new_record?
      end
    end
  end

  def flickr_photo
    query = terms.join
    photos = flickr_client.photos.search(text: query.blank? ? 'lolcats' : query, extras: EXTRAS).to_a
    photos = flickr_client.photos.search(text: terms.first, extras: EXTRAS).to_a if photos.empty? && terms.length > 1
    photos = flickr_client.photos.search(text: 'lolcats', extras: EXTRAS).to_a if photos.empty?
    photos.sample
  end

  def cache_key
    "statuses/#{@id}"
  end

  private

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret = ENV.fetch("TWITTER_CONSUMER_SECRET")
    end
  end

  def flickr_client
    @flickr_client ||= Flickr.new
  end

  def term_extraction
    Rails.cache.fetch("statuses/#{id}/term_extraction") do
      TermExtraction::Yahoo.new(:api_key => ENV["YAHOO_API_KEY"], :context => self.text)
    end
  end

end
