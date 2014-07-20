class WelcomeController < ApplicationController

  def index
  end

  def show
    if params[:actor]
      actor_name = params[:actor]
      # actor_imdb_id = FreebaseApi.get_actor_details(actor_name)
      # @actor_image = ImdbActorImageScraper.scrape_actor_image(actor_imdb_id)

      @actor_image = ActorImageScraper.scrape_actor_image(actor_name)
      @actor = actor_name
      @movies = FreebaseApi.get_actor_movies(actor_name)
    else
      rt_movie_object = RottenTomatoesApi.search(params[:movie])
      # movie_imdb_id = FreebaseApi.get_movie_thumbnail(movie_title)
      # @movie_poster_image = MoviePosterScraper.scrape_movie_poster(movie_imdb_id)

      @movie_poster_image = rt_movie_object["movies"].first["posters"]["original"].gsub("tmb", "ori") if rt_movie_object["movies"]
      movie_title = params[:movie]
      @movie = movie_title
      @actors = FreebaseApi.get_movie_cast(movie_title)
    end
  end
end
