class AddStarterChoiceAndGenderToAttempt < ActiveRecord::Migration[8.0]
  def change
    add_column :attempts, :starter_choice, :string, null: false, default: "grass"
    add_column :attempts, :character_gender, :string, null: false, default: "m"
  end
end
