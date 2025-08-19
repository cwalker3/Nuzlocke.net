class GameItem < ApplicationRecord
  belongs_to :split
  belongs_to :area
  belongs_to :items
end
