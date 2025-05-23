class AddNameToNuzlocke < ActiveRecord::Migration[8.0]
  def change
    add_column :nuzlockes, :name, :string
  end
end
