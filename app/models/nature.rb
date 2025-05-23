class Nature < ApplicationRecord
  def pretty_name
    name.titleize
  end
end
