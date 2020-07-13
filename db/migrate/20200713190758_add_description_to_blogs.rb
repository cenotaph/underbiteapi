class AddDescriptionToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :description, :text
  end
end
