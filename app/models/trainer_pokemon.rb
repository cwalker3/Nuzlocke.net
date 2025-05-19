class TrainerPokemon < ApplicationRecord
  belongs_to :trainer
  belongs_to :pokemon

  has_many :kill_events_as_victim, class_name: "KillEvent", foreign_key: "trainer_pokemon_id", dependent: :destroy
  has_many :killers, through: :kill_events_as_victim, source:  :killer

  has_many :participation_events, dependent: :destroy, foreign_key: :trainer_pokemon_id
  has_many :challengers, through: :participation_events, foreign_key: :attempt_pokemon_id

  enum gender: {
    male: 'm',
    female: 'f',
    genderless: 'g'
  }
end
