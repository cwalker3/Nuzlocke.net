class TrainersController < ApplicationController
  before_action :set_trainer, :set_attempt

  def show
    @defeated = @attempt.defeated_trainers.include?(@trainer)
  end

  def show_basic
    render partial: 'trainers/trainer_basic', locals: { trainer: @trainer }
  end

  private

  def set_attempt
    @attempt = Attempt.find(params[:attempt_id])
  end

  def set_trainer
    @trainer = Trainer
      .includes(trainer_pokemon: [
        :move1,
        :move2,
        :move3,
        :move4,
        :item,
        { game_pokemon: :pokemon }
      ]).find(params[:id])
  end
end
