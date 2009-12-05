class Status
  attr_reader :id
  
  def initialize(id)
    @id = id
    @record = Rails.cache.fetch("statuses/#{id}") { client.statuses.show?(:id => id.to_i) }
  end
  
  # Delegate everything to the TwitterStruct
  def method_missing(sym, *args)
    @record.__send__(sym, *args) if @record.respond_to?(sym)
  end
  
  def url
    "http://twitter.com/#{@record.user.screen_name}/status/#{@id}"
  end
  
  private
  
  def client
    @@client ||= Grackle::Client.new
  end
end
