class AddSlugToArtist < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :slug, :string
    add_index :artists, :slug, unique: true
    add_column :labels, :slug, :string
    add_index :labels, :slug, unique: true
    add_column :artists, :alphabetical_name, :string
  end
end
