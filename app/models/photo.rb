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
  
  def fleakr=(fleakr_photo)
    fleakr_photo = fleakr_photo.dup
    self.flickr_id     = fleakr_photo.id
    self.title         = fleakr_photo.title
    self.description   = fleakr_photo.description
    self.url           = fleakr_photo.small.page.sub('/sizes/s/', '/')
    self.medium_url    = fleakr_photo.medium.url
    self.small_url     = fleakr_photo.small.url
    self.square_url    = fleakr_photo.square.url
    self.thumbnail_url = fleakr_photo.thumbnail.url
    fleakr_photo
  end

end
