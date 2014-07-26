class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_game
    if cookies[:game_id]
      game_id = cookies.signed[:game_id]
      @current_game = Game.find_by_id(game_id)
    end
  end

  helper_method :current_game

end
