class AreasController < ApplicationController
  def new
    @area = Area.new
    @game = Game.find(params[:game_id])
  end

  def create
    @area = Area.new(allowed_area_params)
    @game = @area.game
    if @area.save
        redirect_to game_path(id: @game.id, area_id: @area.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @area = Area.includes(:area_pokemon, trainers: :trainer_pokemon).find(params[:id])
    @game = @area.game
  end

  private

  def allowed_area_params
    params.expect([area: [:name, :game_id]])
  end
end
