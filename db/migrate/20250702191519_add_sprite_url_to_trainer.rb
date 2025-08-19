class AddSpriteUrlToTrainer < ActiveRecord::Migration[8.0]
  def change
    add_column :trainers, :sprite_url, :string
  end
end
