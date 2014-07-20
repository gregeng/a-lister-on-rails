class WelcomeController < ApplicationController

  def index
  end

  def show
    if params[:actor]
      @actor_image = ActorImageScraper.scrape_actor_image(params[:actor])
      @actor = params[:actor]
      @movies = FreebaseApi.get_actor_movies(params[:actor])
    else
      @movie = params[:movie]
      @actors = FreebaseApi.get_movie_cast(params[:movie])
    end
  end


end
