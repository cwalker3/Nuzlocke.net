class Attempt < ApplicationRecord
  belongs_to :nuzlocke
  has_many :attempt_pokemon
  has_many :defeated_trainers
  has_many :attempt_items

  enum status: {
    current: 0,
    wiped: 1,
    reset: 2
  }
end
