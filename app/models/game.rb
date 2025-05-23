class Game < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :nuzlockes
  has_many :attempts, through: :nuzlockes
  has_many :trainers
  has_many :areas
  has_many :game_items

  def active_nuzlockes_count
    self.nuzlockes.where(status: 'active').count
  end

  def completed_attempts
    attempts.completed.count
  end

  def total_attempts_count
    attempts.count
  end
end
