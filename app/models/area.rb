class Area < ApplicationRecord
  belongs_to :game
  has_many :trainers, -> { order(position: :asc) }, dependent: :destroy
  has_many :area_pokemon, dependent: :destroy
  has_many :game_items, dependent: :destroy
  has_many :area_pokemon, dependent: :destroy

  def area_pokemon_by_method
    area_pokemon.includes(game_pokemon: :pokemon).group_by(&:encounter_method)
  end

  def default_content
    if trainers.exists?
      'trainers'
    elsif area_pokemon.exists?
      'pokemon'
    end
  end

  def trainers_for(attempt)
    return trainers unless attempt
    starter_choice = attempt.starter_choice
    attempt_gender = attempt.character_gender
    all_area_trainers = self.trainers.includes( trainer_pokemon: [
                                          :item,
                                          :ability, 
                                          :nature, 
                                          :move1, 
                                          :move2, 
                                          :move3, 
                                          :move4
                                        ]
                                      )
    attempt_trainers = all_area_trainers.select{|t| (t.starter_requirement == nil) || (t.starter_requirement == starter_choice)}
    attempt_trainer = attempt_trainers.select{|t| (t.gender_requirement == 'either') || (t.gender_requirement == attempt_gender)}
  end
end
