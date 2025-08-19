class AttemptPokemonController < ApplicationController
  before_action :set_attempt, only: [:index]
  before_action :set_attempt_pokemon, only: [:edit, :update, :show, :remove_from_party]

  def show
  end

  def index
    @attempt_pokemon = @attempt.attempt_pokemon
  end

  def create
    @attempt_pokemon = AttemptPokemon.new(attempt_pokemon_params)
    @attempt = Attempt.find(@attempt_pokemon.attempt_id)
    @area = Area.find(params[:attempt_pokemon][:area_id])
    if @attempt_pokemon.save
      redirect_to area_path(@area, attempt_id: @attempt.id)
    else
      redirect_to game_areas_path(@attempt_pokemon.game, attempt_id: @attempt.id)
    end
  end

  def edit
    @natures = Nature.all
    @moves = @attempt_pokemon.game_pokemon.moves
    @abilities = @attempt_pokemon.game_pokemon.abilities
    @items = Item.all
  end

  def update
    @game = @attempt_pokemon.attempt.game
    @attempt_pokemon.update(attempt_pokemon_params)
    if @attempt_pokemon.save!
      render :show
    end
  end

  def destroy
    @attempt_pokemon.destroy

    respond_to do |format|
      format.turbo_stream { render partial: "attempt_pokemon/refresh_party_and_box" }
    end
  end

  def add_to_party
    @pokemon = AttemptPokemon.find(params[:fromPokemon])
    @pokemon.update(party_position: params[:partyPosition], box_position: nil)
    @party = @pokemon.attempt.party
    @box = @pokemon.attempt.box

    respond_to do |format|
      format.turbo_stream { render partial: "attempt_pokemon/refresh_party_and_box" }
    end
  end

  def remove_from_party
    @attempt_pokemon.remove_from_party
    @party = @attempt_pokemon.attempt.party
    @box = @attempt_pokemon.attempt.box

    respond_to do |format|
      format.turbo_stream { render partial: "attempt_pokemon/refresh_party_and_box" }
    end
  end

  def swap_pokemon
    @pokemon1 = AttemptPokemon.find(params[:fromPokemon])
    @pokemon2 = AttemptPokemon.find(params[:toPokemon])
    @pokemon1.swap(@pokemon2)
    @party = @pokemon1.attempt.party
    @box = @pokemon1.attempt.box

    respond_to do |format|
      format.turbo_stream { render partial: "attempt_pokemon/refresh_party_and_box" }
    end
  end

  private

  def attempt_pokemon_params
    params.require(:attempt_pokemon).permit(:game_pokemon_id, :attempt_id, :nickname, :nature_id, :ability_id, :hp_iv, :attack_iv, :defense_iv, :special_attack_iv, :special_defense_iv, :speed_iv, :area_id, :item_id, :move_1_id, :move_2_id, :move_3_id, :move_4_id)
  end

  def set_attempt
    @attempt = Attempt.find(params[:attempt_id])
  end

  def set_attempt_pokemon
    @attempt_pokemon = AttemptPokemon.find(params[:id])
  end
end
