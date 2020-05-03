class AddNotNullConstraintsToPhotos < ActiveRecord::Migration[5.1]
  def change
    change_column_null :photos, :twitter_status_id, false
    change_column_null :photos, :medium_url, false
    change_column_null :photos, :small_url, false
    change_column_null :photos, :square_url, false
    change_column_null :photos, :thumbnail_url, false
    change_column_null :photos, :flickr_id, false
    change_column_null :photos, :title, false
    change_column_null :photos, :description, false
    change_column_null :photos, :url, false
  end
end
