class CreateRules < ActiveRecord::Migration[8.0]
  def change
    create_table :rules do |t|
      t.string :name

      t.timestamps
    end
  end
end
