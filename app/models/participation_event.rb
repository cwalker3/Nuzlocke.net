class ParticipationEvent < ApplicationRecord
  belongs_to :attempt_pokemon
  belongs_to :trainer
end
