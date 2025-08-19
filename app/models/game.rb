class Game < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :nuzlockes, dependent: :destroy
  has_many :attempts, through: :nuzlockes,  dependent: :destroy
  has_many :areas, dependent: :destroy
  has_many :game_items, dependent: :destroy
  has_many :splits, dependent: :destroy
  has_many :moves, dependent: :destroy
  has_many :game_pokemon, -> { order(:id) }, dependent: :destroy

  def pretty_title
    title.gsub('-', ' ').titleize
  end

  def to_param
    title
  end
end
