class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :twitter_status_id, "bigint unsigned"
      t.string :medium_url
      t.string :small_url
      t.string :square_url
      t.string :thumbnail_url
      t.column :flickr_id, "bigint unsigned"
      t.string :title
      t.string :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
