class Nuzlocke < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :nuzlocke_rules
  has_many :rules, through: :nuzlocke_rules
  has_many :attempts

  after_create_commit :create_initial_attempt


  private

  def create_initial_attempt
    attempts.create!(status: :active)
  end
end
