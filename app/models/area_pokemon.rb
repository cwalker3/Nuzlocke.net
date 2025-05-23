class AreaPokemon < ApplicationRecord
  belongs_to :area
  belongs_to :pokemon
  has_one :species, through: :pokemon
end
