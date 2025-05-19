class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :title

      t.timestamps
    end
    add_index :games, :title, unique: true
  end
end
