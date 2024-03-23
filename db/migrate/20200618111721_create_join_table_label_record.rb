class CreateJoinTableLabelRecord < ActiveRecord::Migration[6.0]
  def change
    create_join_table :labels, :records do |t|
      t.index %i[label_id record_id]
      t.index %i[record_id label_id]
    end
  end
end
