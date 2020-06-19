class CreateJoinTableArtistRecord < ActiveRecord::Migration[6.0]
  def change
    create_join_table :artists, :records do |t|
      # t.index [:artist_id, :record_id]
      # t.index [:record_id, :artist_id]
    end
  end
end
