class AddDescriptionToRule < ActiveRecord::Migration[8.0]
  def change
    add_column :rules, :description, :string
  end
end
