class CreateNatures < ActiveRecord::Migration[8.0]
  def change
    create_table :natures do |t|
      t.string :name

      t.timestamps
    end
  end
end
