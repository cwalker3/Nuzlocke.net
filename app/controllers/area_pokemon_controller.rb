class AreaPokemonController < ApplicationController
  def index
    @area = Area.find(params[:area_id])
    @area_pokemon = @area.area_pokemon.includes(:game_pokemon)
  end
end
