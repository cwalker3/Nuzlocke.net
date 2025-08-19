class Item < ApplicationRecord
  has_many :game_items
  has_many :attempt_items

  def to_s
    name.gsub("-", " ").titleize
  end

  def image_url
    "items/#{name}.png"
  end
end
