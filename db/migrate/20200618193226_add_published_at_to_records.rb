class AddPublishedAtToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :published, :boolean
    add_column :records, :published_at, :datetime
  end
end
