class CreateSplits < ActiveRecord::Migration[8.0]
  def change
    create_table :splits do |t|
      t.string :name
      t.integer :level_cap
      t.references :game, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
