class Nuzlocke < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :nuzlocke_rules
  has_many :rules, through: :nuzlocke_rules
  has_many :attempts

  enum status: {
    planned: 0,
    in_progress: 1,
    completed: 2,
    on_hold: 3,
    dropped: 4
  }
end
