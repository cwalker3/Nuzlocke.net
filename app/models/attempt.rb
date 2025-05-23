class Attempt < ApplicationRecord
  belongs_to :nuzlocke
  has_one :game, through: :nuzlocke
  has_many :attempt_pokemon
  has_many :defeated_trainers
  has_many :attempt_items


  scope :for_game, -> game_id { joins(:nuzlocke).where(nuzlockes: { game_id: game_id } ) }
  scope :active, -> { where(status: 'active') }
  scope :completed, -> { where(status: 'completed')}

  counter_culture [:nuzlocke, :game], column_name: 'total_attempts'
  counter_culture [:nuzlocke, :game], column_name: proc {|attempt| attempt.active ? 'active_attempts' : nil }
  counter_culture [:nuzlocke, :game], column_name: proc {|attempt| attempt.completed ? 'completed_attempts' : nil }
end
