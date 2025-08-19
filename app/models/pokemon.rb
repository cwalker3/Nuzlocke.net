class Pokemon < ApplicationRecord
  has_many :game_pokemon, dependent: :destroy

  def image_url
    # "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{id}.png"
    "pokemon/#{dex_number}.png"
  end

  def icon_url
    "box-icons/#{dex_number}.png"
  end
end