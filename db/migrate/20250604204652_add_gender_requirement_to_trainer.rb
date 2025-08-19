class AddGenderRequirementToTrainer < ActiveRecord::Migration[8.0]
  def change
    add_column :trainers, :gender_requirement, :integer, null: false, default: 0
  end
end
