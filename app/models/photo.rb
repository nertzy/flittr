# == Schema Information
# Schema version: 20091206035924
#
# Table name: photos
#
#  id                :integer(4)      not null, primary key
#  twitter_status_id :integer(8)
#  medium_url        :string(255)
#  small_url         :string(255)
#  square_url        :string(255)
#  thumbnail_url     :string(255)
#  flickr_id         :integer(8)
#  title             :string(255)
#  description       :string(255)
#  url               :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Photo < ActiveRecord::Base
  validates_presence_of :flickr_id
  validates_presence_of :twitter_status_id
  validates_presence_of :url, :allow_blank => false
  validates_uniqueness_of :twitter_status_id

  def flickr=(flickr_photo)
    self.flickr_id     = flickr_photo["id"]
    self.title         = flickr_photo["title"]
    self.description   = flickr_photo["description"]
    self.url           = "https://www.flickr.com/photos/#{flickr_photo["owner"]}/#{flickr_photo["id"]}/"
    self.medium_url    = flickr_photo["url_m"]
    self.small_url     = flickr_photo["url_s"]
    self.square_url    = flickr_photo["url_sq"]
    self.thumbnail_url = flickr_photo["url_t"]
    flickr_photo
  end

end
