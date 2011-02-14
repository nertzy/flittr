require 'term_extraction'
require_dependency 'photo'

class Status
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
    @record ||= Rails.cache.fetch("statuses/#{id}") { twitter_client.statuses.show?(:id => id.to_i) }
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
      Photo.find_or_create_by_twitter_status_id(@id) do |photo|
        photo.fleakr = flickr_photo if photo.new_record?
      end
    end
  end
  
  def flickr_photo
    Rails.cache.fetch("#{cache_key}/flickr_photo", :raw => true) do
      query = terms
      photos = Fleakr.search(query.blank? ? 'lolcats' : query)
      photos = Fleakr.search(terms.first) if photos.empty? && terms.length > 1
      photos = Fleakr.search('lolcats') if photos.empty?
      photos.rand
    end
  end
  
  def cache_key
    "statuses/#{@id}"
  end
  
  private
  
  def twitter_client
    @@twitter_client ||= Grackle::Client.new
  end
  
  def term_extraction
    Rails.cache.fetch("statuses/#{id}/term_extraction") do
      TermExtraction::Yahoo.new(:api_key => Yahoo::API_KEY, :context => self.text)
    end
  end
  
end
