class CreateJoinTableLabelRecord < ActiveRecord::Migration[6.0]
  def change
    create_join_table :labels, :records do |t|
      t.index [:label_id, :record_id]
      t.index [:record_id, :label_id]
    end
  end
end
