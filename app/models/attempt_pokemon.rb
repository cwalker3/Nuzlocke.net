class AttemptPokemon < ApplicationRecord
  belongs_to :attempt
  belongs_to :game_pokemon
  has_one :pokemon, through: :game_pokemon
  has_one :user, through: :attempt
  belongs_to :nature, optional: true
  has_one :game, through: :attempt
  belongs_to :move_1, class_name: "Move", optional: true
  belongs_to :move_2, class_name: "Move", optional: true
  belongs_to :move_3, class_name: "Move", optional: true
  belongs_to :move_4, class_name: "Move", optional: true
  belongs_to :ability, optional: true
  belongs_to :item, optional: true
  delegate :species, to: :pokemon

  has_paper_trail

  has_many :kill_events_as_killer, class_name:  "KillEvent", foreign_key: "attempt_pokemon_id", dependent: :destroy
  has_many :victims, through: :kill_events_as_killer, source: :victim

  has_many :participation_events, dependent: :destroy, foreign_key: :attempt_pokemon_id
  has_many :participated_battles, through: :participations_events, source: :trainer

  validates :party_position, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }, allow_nil: true
  validates :party_position, uniqueness: { scope: :attempt_id, message: "is already taken in party" }, allow_nil: true

  enum :status, { alive: 0, dead: 1 }

  acts_as_list scope: :attempt, column: :box_position

  after_create :add_to_party_if_room

  def swap(pokemon2)
    pokemon_1_party_position = self.party_position
    pokemon_1_box_position = self.box_position
    pokemon_2_party_position = pokemon2.party_position
    pokemon_2_box_position = pokemon2.box_position

    ApplicationRecord.transaction do
      pokemon2.update!(party_position: nil)
      self.update!(box_position: pokemon_2_box_position,
                  party_position: pokemon_2_party_position)
      pokemon2.update!(box_position: pokemon_1_box_position,
                      party_position: pokemon_1_party_position)
    end
  end

  def remove_from_party
    update!(party_position: nil)
    insert_at((attempt.attempt_pokemon.maximum(:box_position) || 0) + 1)
  end

  def to_s
    nickname || species
  end

  private

  def add_to_party_if_room
    return unless attempt.party_has_room?

    attempt.add_to_party(self)
    update_column(:box_position, nil)
  end
end
