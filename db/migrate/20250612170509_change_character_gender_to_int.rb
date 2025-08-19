class ChangeCharacterGenderToInt < ActiveRecord::Migration[8.0]
  def change
    remove_column :attempts, :character_gender
    add_column :attempts, :character_gender, :integer
  end
end
