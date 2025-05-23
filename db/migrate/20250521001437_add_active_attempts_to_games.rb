class AddActiveAttemptsToGames < ActiveRecord::Migration[8.0]
  def self.up
    add_column :games, :active_attempts, :integer, null: false, default: 0
  end

  def self.down
    remove_column :games, :active_attempts
  end
end
