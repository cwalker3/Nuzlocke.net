class Rule < ApplicationRecord
  has_many :nuzlocke_rules
  has_many :nuzlockes, through: :nuzlocke_rules
end
