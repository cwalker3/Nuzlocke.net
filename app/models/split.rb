class Split < ApplicationRecord
  belongs_to :game
  has_many :trainers
  has_many :areas
  has_many :game_items
end
