class CreateTrainers < ActiveRecord::Migration[8.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
