class AddFieldsToTrainer < ActiveRecord::Migration[8.0]
  def change
    add_column :trainers, :mandatory, :boolean
    add_column :trainers, :notes, :string
    add_column :trainers, :reward, :string
  end
end
