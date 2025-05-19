class AttemptItem < ApplicationRecord
  belongs_to :items
  belongs_to :attempt
end
