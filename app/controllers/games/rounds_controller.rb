class Games::RoundsController < ApplicationController
  def show
    @round = Game.find(params[:game_id])
  end

end
