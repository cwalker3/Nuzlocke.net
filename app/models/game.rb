class Game < ApplicationRecord
  has_many :nuzlockes
  has_many :trainers
  has_many :areas
  has_many :game_items
