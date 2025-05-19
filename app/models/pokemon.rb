class Pokemon < ApplicationRecord
  has_many :area_pokemon
  has_many :attempt_pokemon
  has_many :trainer_pokemon
end
