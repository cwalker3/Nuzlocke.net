class GamePokemon < ApplicationRecord
  has_many :area_pokemon, dependent: :destroy
  has_many :attempt_pokemon, dependent: :destroy
  has_many :trainer_pokemon, dependent: :destroy
  has_many :pokemon_moves, dependent: :destroy
  has_many :moves, through: :pokemon_moves
  belongs_to :type_1, class_name: "Type"
  belongs_to :type_2, class_name: "Type", optional: true
  belongs_to :game
  belongs_to :pokemon
  belongs_to :ability_1, class_name: "Ability"
  belongs_to :ability_2, optional: true, class_name: "Ability"
  belongs_to :ability_3, optional: true, class_name: "Ability"
  delegate :species, to: :pokemon

  def abilities
    [ability_1, ability_2, ability_3].compact
  end

  def level_up_moves
    pokemon_moves.where(method: "Level")
  end

  def tm_moves
    pokemon_moves.where(method: "TM")
  end

  def stat_color(stat)
    value = read_attribute(stat)

    case value
      when   0..51   then "#ff0000"
      when  52..81   then "#ffa500"
      when  82..100  then "#ffff00"
      when 100..180  then "#008000" 
      else                "#808080"
    end
  end
end
