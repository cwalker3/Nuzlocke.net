class Move < ApplicationRecord
  belongs_to :game
  belongs_to :type
  has_many :pokemon_moves, dependent: :destroy

  enum :category, { Physical: 0, Special: 1, Status: 2 }

  def category_image_url
    "move-icons/#{category}.png"
  end

  def priority_formatted
    if priority <= 0
      "#{priority} Priority"
    else
      "+#{priority} Priority"
    end
  end

  def to_s
    name
  end
end
