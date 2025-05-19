class Item < ApplicationRecord
  has_many :game_items
  has_many :attempt_items
end
