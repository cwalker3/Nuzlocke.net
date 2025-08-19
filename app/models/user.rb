class User < ApplicationRecord
  has_many :nuzlockes
  has_many :attempts, through: :nuzlockes

  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :email, presence: true, uniqueness: true

  def has_active_attempt_for?(game_id)
    active_attempt_for(game_id).exists?
  end

  def active_attempt_for(game_id)
    User.first.attempts.for_game(game_id).active
  end

  def active_nuzlockes
    Nuzlocke.first
  end
end
