require 'term_extraction'
require_dependency 'photo'

class Status
  attr_reader :id
  
  def initialize(options = {})
    @record ||= options[:record]
    @user ||= options[:user]
    @id = @record ? @record.id : options[:id]
    raise ArgumentError("id not given") unless @id
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
  
  def url
    "http://twitter.com/#{user.screen_name}/status/#{@id}"
  end
  
  def terms
    term_extraction.terms
  end

  def photo
    Rails.cache.fetch("#{cache_key}/photo") do
      Photo.find_or_create_by_twitter_status_id(@id) do |photo|
        photo.fleakr = flickr_photo
        photo.save!
      end
    end
  end
  
  def flickr_photo
    Rails.cache.fetch("#{cache_key}/flickr_photo", :raw => true) do
      query = terms.join(' ')
      photo = Fleakr.search(query.blank? ? 'lolcats' : query).rand
      photo || Fleakr.search('lolcats').rand
    end
  end
  
  def cache_key
    "statuses/#{@id}"
  end
  
  private
  
  def twitter_client
    @@twitter_client ||= Grackle::Client.new
  end
  
  # def flickr_client
  #   @@flickr_client ||= Flickr.new(File.join(Rails.root, 'config', 'flickr.yml'))
  # end

  def term_extraction
    Rails.cache.fetch("statuses/#{id}/term_extraction") do
      TermExtraction::Yahoo.new(:api_key => 'KEY_GOES_HERE', :context => self.text)
    end
  end
  
end
