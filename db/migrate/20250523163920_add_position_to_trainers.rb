class AddPositionToTrainers < ActiveRecord::Migration[8.0]
  def up
    add_column :trainers, :position, :integer
    Trainer.order(:created_at).each_with_index do |t, i|
      t.update_columns(position: i + 1)
    end
    change_column_null :trainers, :position, false
  end

  def down
    remove_column :trainers, :position
  end
end
