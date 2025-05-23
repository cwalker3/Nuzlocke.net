class AreaPokemonController < ApplicationController
    before_action :set_area, only: %i[index new edit update create]
    # before_action :set_area_pokemon, only: %i[edit update]
    before_action :set_all_area_pokemon, only: %i[index update create]
  
  def index
    @area_pokemon = @area.area_pokemon.includes(:pokemon)
  end

  def new
    @area_pokemon = AreaPokemon.new
    @pokemon = Pokemon.all
  end

  def create
    @area = Area.find(params[:area_pokemon][:area_id])
    @area_pokemon = AreaPokemon.new(allowed_params)

    if @area_pokemon.save
      respond_to do |format|
        format.html { redirect_to new_pokemon_path(area_id: @area.id) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @area_pokemon = AreaPokemon.find(params[:id])
    @pokemon = Pokemon.all
  end

  def update
    @area_pokemon = AreaPokemon.find(params[:id])
    if @area_pokemon.update(allowed_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to area_pokemon_path(@area_pokemon) }
      end
    else 
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def allowed_params
    params.require(:area_pokemon).permit(:pokemon_id, :area_id, :encounter_method, :encounter_rate)
  end

  def set_area
    if params[:area_id]
      @area = Area.find(params[:area_id])
    elsif params[:area_pokemon] && params[:area_pokemon][:area_id]
      @area = Area.find(params[:area_pokemon][:area_id])
    end
  end

  def set_area_pokemon
    @area_pokemon = AreaPokemon.find(params[:id])
  end

  def set_all_area_pokemon
    @all_area_pokemon = @area.area_pokemon
  end
end
