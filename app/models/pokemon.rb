class Pokemon < ApplicationRecord
  has_many :game_pokemon, dependent: :destroy

  def image_url
    "pokemon/#{dex_number}.png"
  end

  def icon_url
    "box-icons/#{dex_number}.png"
  end
end
