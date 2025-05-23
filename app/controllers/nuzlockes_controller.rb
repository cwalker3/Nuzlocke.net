class NuzlockesController < ApplicationController
  before_action :set_game
  def new
    @nuzlocke = @game.nuzlockes.build
  end

  def create
    @nuzlocke = current_user.nuzlockes.build(allowed_nuzlocke_params)
    @nuzlocke.game = @game
    if @nuzlocke.save
      redirect_to game_path(@game, area_id: @area.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @nuzlocke = Nuzlocke.find(params[:id])
  end

  private

  def allowed_nuzlocke_params
    params.expect([nuzlocke: [:name, :status]])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
