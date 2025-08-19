class Nuzlocke < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :nuzlocke_rules
  has_many :rules, through: :nuzlocke_rules
  has_many :attempts, dependent: :destroy
  has_one :active_attempt, -> { where(status: :active) }, class_name: 'Attempt'

  enum :status, { active: 0, completed: 1, on_hold: 2, dropped: 3 }
end
