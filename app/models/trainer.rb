class Trainer < ApplicationRecord
  belongs_to :area
  has_many :trainer_pokemon, -> { order(position: :asc) }, dependent: :destroy

  has_many :participation_events, dependent: :destroy, foreign_key: :trainer_id
  has_many :challengers, through: :participation_events, foreign_key: :attempt_pokemon_id

  acts_as_list scope: :area

  accepts_nested_attributes_for :trainer_pokemon, allow_destroy: true, reject_if: proc { |attrs|
                                  # drop any slot lacking both a Pokemon and a level
                                  attrs['pokemon_id'].blank? && attrs['level'].blank?}

  validates :name, length: { minimum: 1, message: "Name can't be blank" }
end
