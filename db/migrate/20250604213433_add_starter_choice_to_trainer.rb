class AddStarterChoiceToTrainer < ActiveRecord::Migration[8.0]
  def change
    add_column :trainers, :starter_requirement, :integer, default: 0, null: false
  end
end
