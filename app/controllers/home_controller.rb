class HomeController < ApplicationController
  def index 
    if user_signed_in?
      @active_nuzlockes = current_user.nuzlockes.includes(:game)
    end
  end
end
