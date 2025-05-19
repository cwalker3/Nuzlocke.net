class RemoveNuzlockes < ActiveRecord::Migration[8.0]
  def change
    drop_table :nuzlockes
  end
end
