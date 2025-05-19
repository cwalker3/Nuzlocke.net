class Trainer < ApplicationRecord
  belongs_to :area
  has_many :trainer_pokemon
  has_many :participation_events

  enum type: {
    mandatory: 0,
    optional: 1,
    spinner: 2
  }
end
