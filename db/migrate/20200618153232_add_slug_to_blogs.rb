class AddSlugToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :slug, :string
    add_index :blogs, :slug, unique: true
    add_column :records, :slug, :string
    add_index :records, :slug, unique: true
  end
end
