class TrainerPokemonController < ApplicationController
  def show
    @trainer_pokemon = TrainerPokemon.find(params[:id])
  end
end
