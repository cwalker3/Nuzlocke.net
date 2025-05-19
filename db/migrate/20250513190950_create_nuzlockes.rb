class CreateNuzlockes < ActiveRecord::Migration[8.0]
  def change
    create_table :nuzlockes do |t|
      t.integer :status
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
