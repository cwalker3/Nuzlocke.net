class Pokemon < ApplicationRecord
  has_many :area_pokemon, dependent: :destroy
  has_many :attempt_pokemon, dependent: :destroy
  has_many :trainer_pokemon, dependent: :destroy

    def pretty_name
    species.gsub("-", " ").titleize
  end
end
