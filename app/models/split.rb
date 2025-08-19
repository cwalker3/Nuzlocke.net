class Split < ApplicationRecord
  belongs_to :game
  has_many :trainers
end
