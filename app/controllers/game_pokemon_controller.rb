class GamePokemonController < ApplicationController
  def show
    @game_pokemon = GamePokemon.find(params[:id])
  end

  def index
    @game = Game.find_by(title: params[:game_id])
    @game_pokemon = @game.game_pokemon.includes(:type_1, :type_2, :ability_1, :ability_2, :ability_3, :pokemon, :moves)
  end
end
