class TrainerPokemon < ApplicationRecord
  belongs_to :trainer
  belongs_to :pokemon
  belongs_to :item, optional: true
  belongs_to :ability, optional: true
  belongs_to :nature, optional: true
  belongs_to :move1, class_name: "Move", optional: true
  belongs_to :move2, class_name: "Move", optional: true
  belongs_to :move3, class_name: "Move", optional: true
  belongs_to :move4, class_name: "Move", optional: true

  has_many :kill_events_as_victim, class_name: "KillEvent", foreign_key: "trainer_pokemon_id", dependent: :destroy
  has_many :killers, through: :kill_events_as_victim, source:  :killer

  acts_as_list scope: :trainer

  validates :level, numericality: { only_integer: true, in: 1..100 }
end
