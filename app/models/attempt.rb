class Attempt < ApplicationRecord
  belongs_to :nuzlocke, counter_cache: true
  has_one :game, through: :nuzlocke
  has_many :attempt_pokemon, dependent: :destroy
  has_many :defeated_trainer_records, class_name: 'DefeatedTrainer', dependent: :destroy
  has_many :defeated_trainers, through: :defeated_trainer_records, source: :trainer
  has_many :attempt_items, dependent: :destroy

  validate :one_active_attempt, on: :create

  before_create :set_attempt_number

  scope :for_game, -> game_id { joins(:nuzlocke).where(nuzlockes: { game_id: game_id }) }
  scope :active, -> { where(status: 'active') }
  scope :completed, -> { where(status: 'completed')}

  enum :status, { active: 0, completed: 1, on_hold: 2, dropped: 3 }
  enum :starter_choice, { grass: 0, fire: 1, water: 2 }
  enum :character_gender, { male: 0, female: 1 }

  counter_culture [:nuzlocke, :game], column_name: 'total_attempts'
  counter_culture [:nuzlocke, :game],
    column_name: ->(a) { a.active? ? 'active_attempts' : nil },
    column_names: {
      # Only count attempts where status = 0 (active)
      ["attempts.status = ?", Attempt.statuses[:active]] => 'active_attempts'
    }

  # 3) Completed attempts
  counter_culture [:nuzlocke, :game],
    column_name: ->(a) { a.completed? ? 'completed_attempts' : nil },
    column_names: {
      # Only count attempts where status = 1 (completed)
      ["attempts.status = ?", Attempt.statuses[:completed]] => 'completed_attempts'
    }

  def encounter_available_for(area)
    !encountered_areas.include?(area.id)
  end

  def box
    attempt_pokemon.includes(game_pokemon: :pokemon).where.not(box_position: nil).order(:box_position)
  end

  def party
    party_hash = attempt_pokemon.includes(game_pokemon: :pokemon).where.not(party_position: nil).index_by(&:party_position)
    (1..6).map { |slot| party_hash[slot] }
  end

  def party_has_room?
    party.include?(nil)
  end

  def add_to_party(pokemon)
    slot = first_available_party_slot
    pokemon.update(party_position: slot)
  end

  private

  def encountered_areas
    attempt_pokemon.map { |ap| ap.area_id }
  end

  def one_active_attempt
    if nuzlocke.active_attempt.present?
      errors.add(:base, 'An active attempt already exists for this Nuzlocke')
    end
  end

  def set_attempt_number
    self.number = nuzlocke.attempts.count + 1
  end

   def first_available_party_slot
    (1..6).find{ |slot| party[slot - 1].nil? }
  end
end
