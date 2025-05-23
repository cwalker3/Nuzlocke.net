class Item < ApplicationRecord
  has_many :game_items
  has_many :attempt_items

  def pretty_name
    name.gsub("-", " ").titleize
  end
end
