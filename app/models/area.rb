class Area < ApplicationRecord
  belongs_to :game
  has_many :trainers
  has_many :area_pokemon
  has_many :game_items
end
