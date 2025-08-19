class PokemonMove < ApplicationRecord
  belongs_to :move
  belongs_to :game_pokemon

  enum :method, { "Level": 0, "TM": 1 }
end
