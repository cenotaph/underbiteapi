class AddDiscogsIdToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :discogs_id, :integer
  end
end
