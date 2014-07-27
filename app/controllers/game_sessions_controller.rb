class GameSessionsController < ApplicationController

  def new
  end

  def create
    game = Game.create(params[:game_session])
    cookies[:game_id] = game.id
    redirect_to welcome_path
  end

  def destroy
  end

end
