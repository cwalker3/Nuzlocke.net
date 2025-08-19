class NuzlockesController < ApplicationController
  def index
    
  end

  def new
    @games = Game.all
    @nuzlocke = Nuzlocke.new
  end

  def create
    @nuzlocke = current_user.nuzlockes.build(nuzlocke_params)
    if @nuzlocke.save
      redirect_to nuzlocke_path(@nuzlocke)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @nuzlocke = Nuzlocke.find(params[:id])
    @attempts = @nuzlocke.attempts.order(created_at: :desc)
  end

  private

  def nuzlocke_params
    params.require(:nuzlocke).permit(:name, :game_id)
  end
end
