class MovesController < ApplicationController
  def show
    @move = Move.find(params[:id])
  end
end
