class GameSessionsController < ApplicationController

  def new
  end

  def create
    game = Game.create(game_session_params)
    cookies.signed[:game_id] = game.id
    redirect_to welcome_path
  end

  def destroy
    cookies.delete(:game_id)
    redirect_to welcome_path
  end

  private

  def game_session_params
    params.require(:game_session).permit(:starting_actor)
  end

end
