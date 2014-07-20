class WelcomeController < ApplicationController

  def index
  end

  def show
    if params[:actor]
      @actor_image = ActorImageScraper.scrape_actor_image(params[:actor])
      @actor = params[:actor]
      @movies = FreebaseApi.get_actor_movies(params[:actor])
    else
      rt_movie_object = RottenTomatoesApi.search(params[:movie])
      @movie_poster_image = rt_movie_object["movies"].first["posters"]["original"] if rt_movie_object["movies"]

      @movie = params[:movie]
      @actors = FreebaseApi.get_movie_cast(params[:movie])
    end
  end


end
