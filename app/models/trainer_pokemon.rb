class TrainerPokemon < ApplicationRecord
  belongs_to :trainer
  belongs_to :game_pokemon
  has_one :pokemon, through: :game_pokemon
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

  def moves
    [move1, move2, move3, move4]
  end

  def killer_for_attempt(attempt)
    killers.find_by(attempt_id: attempt.id)
  end

end
