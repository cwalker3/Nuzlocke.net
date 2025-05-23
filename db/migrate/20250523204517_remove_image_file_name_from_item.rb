class RemoveImageFileNameFromItem < ActiveRecord::Migration[8.0]
  def change
    remove_column :items, :image_file_name, :string
  end
end
