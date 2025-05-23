class GamesController < ApplicationController
  before_action :set_area, only: :show

  def show
    @game = Game.includes(:areas).find(params[:id])
  end

  def index
    @games = Game.includes(:nuzlockes, :attempts).order(:title)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(allowed_game_params)
    if @game.save
      render :show
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def allowed_game_params
    params.expect(game: [:title])
  end

  def set_area
    if params[:area_id].present?
      @area = Area.find(params[:area_id])
    elsif Game.find(params[:id]).areas.first
      @area = Game.find(params[:id]).areas.first
    end
  end
end
