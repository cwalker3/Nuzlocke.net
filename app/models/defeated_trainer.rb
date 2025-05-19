class DefeatedTrainer < ApplicationRecord
  belongs_to :attempt
  belongs_to :trainer
end
