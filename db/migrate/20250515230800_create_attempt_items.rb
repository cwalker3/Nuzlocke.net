class CreateAttemptItems < ActiveRecord::Migration[8.0]
  def change
    create_table :attempt_items do |t|
      t.references :items, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
