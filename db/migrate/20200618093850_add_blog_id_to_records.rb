class AddBlogIdToRecords < ActiveRecord::Migration[6.0]
  def change
    add_reference :records, :blog, null: false, foreign_key: true
  end
end
