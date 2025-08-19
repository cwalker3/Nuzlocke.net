class AttemptsController < ApplicationController
  before_action :set_nuzlocke, only: [:new, :create]
  def new
    @attempt = @nuzlocke.attempts.build
  end

  def create
    @attempt = @nuzlocke.attempts.build(attempt_params)

    if @attempt.save
      redirect_to game_path(@attempt.game.title, attempt_id: @attempt.id)
    else render :new, status: :unprocessable_entity
    end
  end

  private

  def set_nuzlocke
    @nuzlocke = Nuzlocke.find(params[:nuzlocke_id])
  end

  def attempt_params
    params.require(:attempt).permit(:character_gender, :starter_choice)
  end
end
