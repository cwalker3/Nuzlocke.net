class RenameKillsToKillEvents < ActiveRecord::Migration[8.0]
  def change
    rename_table :kills, :kill_events
    rename_table :participations, :participation_events

    
  end
end
