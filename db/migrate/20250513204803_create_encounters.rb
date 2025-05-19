class CreateEncounters < ActiveRecord::Migration[8.0]
  def change
    create_table :encounters do |t|
      t.integer :nature
      t.integer :ivs, array: true, default: [0,0,0,0,0,0,]

      t.timestamps
    end
  end
end
