class ParticipationEventsController < ApplicationController
  def create

    render 
  end

  private

  def participation_events_params
    params.permit(:attempt_id)
  end
end
