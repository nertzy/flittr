require 'term_extraction'

class Status
  attr_reader :id
  
  def initialize(id)
    @id = id
    @record = Rails.cache.fetch("statuses/#{id}") { twitter_client.statuses.show?(:id => id.to_i) }
  end
  
  # Delegate everything to the TwitterStruct
  def method_missing(sym, *args)
    @record.__send__(sym, *args) if @record.respond_to?(sym)
  end
  
  def url
    "http://twitter.com/#{@record.user.screen_name}/status/#{@id}"
  end
  
  def terms
    term_extraction.terms
  end
  
  private
  
  def twitter_client
    @@twitter_client ||= Grackle::Client.new
  end
  
  def term_extraction
    Rails.cache.fetch("statuses/#{id}/term_extraction") do
      TermExtraction::Yahoo.new(:api_key => 'KEY_GOES_HERE', :context => self.text)
    end
  end
  
end
