class DefeatedTrainersController < ApplicationController
  before_action :set_attempt, :set_trainer

  def create
    @defeated = @attempt.defeated_trainer_records.find_or_create_by!(trainer: @trainer)

    if @defeated.save
      render partial: 'trainers/trainer_basic', locals: { trainer: @trainer, attempt: @attempt}
    end
  end

  def destroy
    @defeated = @attempt.defeated_trainer_records.find_by(trainer: @trainer)

    if @defeated.destroy
      render partial: 'trainers/trainer_basic', locals: { trainer: @trainer, attempt: @attempt}
    end
  end


  private

  def set_attempt
    @attempt = Attempt.find(params[:attempt_id])
  end

  def set_trainer
    if params[:trainer_id]
      @trainer = Trainer.find(params[:trainer_id])
    else
      @trainer = Trainer.find(params[:id])
    end
  end
end
