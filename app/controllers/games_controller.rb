class GamesController < ApplicationController
  before_action :set_game, only: :show
  before_action :set_attempt, only: :show
  before_action :set_area, only: :show

  def show
    # @game, @attempt, @area
  end

  def index
    @games = Game.order(:title)
  end

  private

   def set_game
    @game = Game.find_by(title: params[:title])
  end

  def set_area
    @area = Area.find_by(id: params[:area_id])
  end
end
