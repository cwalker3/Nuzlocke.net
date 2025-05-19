class CreateAttempts < ActiveRecord::Migration[8.0]
  def change
    create_table :attempts do |t|
      t.references :nuzlocke, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
