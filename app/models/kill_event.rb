class KillEvent < ApplicationRecord
  belongs_to :killer,
             class_name:  "AttemptPokemon",
             foreign_key: "attempt_pokemon_id"

  belongs_to :victim,
             class_name:  "TrainerPokemon",
             foreign_key: "trainer_pokemon_id"
end
