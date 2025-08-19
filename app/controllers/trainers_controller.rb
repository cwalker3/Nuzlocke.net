class TrainersController < ApplicationController
  before_action :set_trainer
  def show
  end

  def show_basic
    render partial: 'trainers/trainer_basic', locals: { trainer: @trainer }
  end

  def battle
    @kill_event = KillEvent.new
    @attempt = Attempt.find_by(id: params[:attempt_id])
  end

  private

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
