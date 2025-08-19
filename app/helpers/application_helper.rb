module ApplicationHelper
  def game_path_with_attempt(game, attempt, extra_params = {})
    game_path(game, attempt_param(attempt).merge(extra_params))
  end

  def game_areas_path_with_attempt(game, attempt)
    game_areas_path(game, attempt_param(attempt))
  end

  def area_path_with_attempt(area, attempt, extra_params={})
    area_path(area, attempt_param(attempt).merge(extra_params)) 
  end

  def attempt_pokemon_index_path_with_attempt(attempt)
    attempt_pokemon_index_path(attempt_param(attempt))
  end

  def attempt_pokemon_create_path_with_attempt(attempt, extra_params={})
    attempt_pokemon_create_path(attempt_param(attempt).merge(extra_params))
  end

  private

  def attempt_param(attempt)
    attempt.present? ? {attempt_id: attempt.id} : {}
  end
end
