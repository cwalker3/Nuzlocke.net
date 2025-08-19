class AddAttemptToKillEvent < ActiveRecord::Migration[8.0]
  def change
    add_reference :kill_events, :attempt, null: false, foreign_key: true
  end
end
