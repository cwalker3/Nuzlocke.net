class AddAbilityToAttemptPokmone < ActiveRecord::Migration[8.0]
  def change
    add_reference :attempt_pokemon, :ability, foreign_key: true
  end
end
