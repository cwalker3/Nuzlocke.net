class AttemptPokemon < ApplicationRecord
  belongs_to :attempt
  belongs_to :pokemon
  has_one :user, through: :attempt

  has_many :kill_events_as_killer, class_name:  "KillEvent", foreign_key: "attempt_pokemon_id", dependent: :destroy
  has_many :victims, through: :kill_events_as_killer, source: :victim

  has_many :participation_events, dependent: :destroy, foreign_key: :attempt_pokemon_id
  has_many :participated_battles, through: :participations_events, source: :trainer
end
