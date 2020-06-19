class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :title
      t.text :review
      t.string :display_name

      t.timestamps
    end
  end
end
