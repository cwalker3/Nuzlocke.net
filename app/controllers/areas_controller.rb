class AreasController < ApplicationController
  def index
    @game = Game.find_by(title: params[:game_title])
    @areas = @game.areas
    @area = @areas.first
    @attempt = Attempt.find_by(id: params[:attempt_id])
    @content = @area.default_content
    @encounter_methods = @area.area_pokemon_by_method
  end

  def show
    @attempt = Attempt.find_by(id: params[:attempt_id])
    @box = @attempt.box if @attempt
    @area = Area.find(params[:id])
    @content = params[:content] || @area.default_content
    @encounter_methods = @area.area_pokemon_by_method
    @trainers = @area.trainers_for(@attempt)
  end
end
