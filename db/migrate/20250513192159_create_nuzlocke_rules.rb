class CreateNuzlockeRules < ActiveRecord::Migration[8.0]
  def change
    create_table :nuzlocke_rules do |t|
      t.references :nuzlocke, null: false, foreign_key: true
      t.references :rule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
