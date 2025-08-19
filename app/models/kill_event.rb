class KillEvent < ApplicationRecord
  belongs_to :attempt_pokemon
  belongs_to :trainer_pokemon
  belongs_to :attempt

  belongs_to :killer,
             class_name:  "AttemptPokemon",
             foreign_key: "attempt_pokemon_id"

  belongs_to :victim,
             class_name:  "TrainerPokemon",
             foreign_key: "trainer_pokemon_id"
  validates :trainer_pokemon_id, 
              uniqueness: { scope: :attempt, 
                            message: 'trainer pokemon already has kill event for this attempt'}

  private

 
end
