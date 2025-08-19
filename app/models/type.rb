class Type < ApplicationRecord
  has_many :moves

  def image_url
    "types/#{name}.png"
  end
end
