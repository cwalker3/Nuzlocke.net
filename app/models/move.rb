class Move < ApplicationRecord
  def pretty_name
    name.gsub("-", " ").titleize
  end
end
