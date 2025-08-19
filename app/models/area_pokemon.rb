class AreaPokemon < ApplicationRecord
  belongs_to :area
  belongs_to :game_pokemon
  has_one :pokemon, through: :game_pokemon

  def formatted_encounter_rate
    "#{encounter_rate}%" if encounter_rate.present?
  end

  def level_range
    if min_level == max_level
      "Level: #{min_level}"
    else
      "Levels: #{min_level} - #{max_level}"
    end
  end
end
