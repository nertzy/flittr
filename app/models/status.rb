class Status < BlankSlate
  attr_reader :status
  
  # Fetch a TwitterStruct
  def initialize(id)
    @status = Rails.cache.fetch("statuses/#{id}") { client.statuses.show?(:id => id.to_i) }
  end

  # Delegate everything to the TwitterStruct
  def method_missing(sym, *args)
    @status.send(sym, *args)
  end
  
  def url
    "http://twitter.com/#{from_user}/status/#{id}"
  end
  
  private
  
  def client
    @@client ||= Grackle::Client.new
  end
end
