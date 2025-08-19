class ChangeStartChoiceToInteger < ActiveRecord::Migration[8.0]
  def change
    remove_column :attempts, :starter_choice
    add_column :attempts, :starter_choice, :integer
  end
end
