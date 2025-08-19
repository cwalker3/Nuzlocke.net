class Trainer < ApplicationRecord
  belongs_to :area
  belongs_to :split
  has_many :trainer_pokemon, -> { order(position: :asc) }, dependent: :destroy

  has_many :participation_events, dependent: :destroy, foreign_key: :trainer_id
  has_many :challengers, through: :participation_events, foreign_key: :attempt_pokemon_id

  enum :gender_requirement, { either: 0, male_only: 1, female_only: 2 }
  enum :trainer_type, { mandatory: 0, optional: 1, spinner: 2 }
  enum :boss_role, { normal: 0, mini_boss: 1, split_boss: 2, elite_four: 3, champion: 4 }
  enum :starter_requirement, { any: 0, grass: 1, fire: 2, water: 3 }

  acts_as_list scope: :area

  validates :name, length: { minimum: 1, message: "Name can't be blank" }

  def split_number_presense_for_split_boss
    if split_boss? && split_number.blank?
      errors.add(:split_number, "must be set if boss_role is split_boss")
    end
  end
end
