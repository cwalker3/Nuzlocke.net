class ChangeTrainerTypeToInteger < ActiveRecord::Migration[8.0]
  def change
    change_column :trainers, :trainer_type, :integer, null: false, default: 0

    add_column :trainers, :boss_role, :integer, null: false, default: 0
  end
end
