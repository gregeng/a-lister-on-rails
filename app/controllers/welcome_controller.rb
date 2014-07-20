class WelcomeController < ApplicationController

  def index
  end

  def show
    if params[:actor]
      actor_name = params[:actor]
      # actor_imdb_id = FreebaseApi.get_actor_details(actor_name)
      # @actor_image = ImdbActorImageScraper.scrape_actor_image(actor_imdb_id)

      # Cuba Gooding, Jr. on FreebaseApi VS Cuba Gooding Jr. in Rotten Tomatoes
      @actor_image = ActorImageScraper.scrape_actor_image(actor_name)
      @actor = actor_name
      @movies = FreebaseApi.get_actor_movies(actor_name)
    else
      # movie_imdb_id = FreebaseApi.get_movie_thumbnail(movie_title)
      # @movie_poster_image = MoviePosterScraper.scrape_movie_poster(movie_imdb_id)

      ### TODO Move all this stuff into the RottenTomatoes Api
      rt_movie_object = RottenTomatoesApi.search(params[:movie])
      rt_movie_id = rt_movie_object["movies"].first["id"]
      @rt_actors = RottenTomatoesApi.get_movie_cast(rt_movie_id)["cast"].collect { |actor| actor["name"] }

      #### Sometimes Freebase gives you a better list of actors than Rotten Tomatoes.
      #### It might be worth having logic to just default to the one that has more.
      #### Or just stick with Rotten Tomatoes for now since then I can just rely on their search algorithm.
      #### Since they will favor more popular titles...like the new Dawn of the Dead / Godzilla

      @movie_poster_image = rt_movie_object["movies"].first["posters"]["original"].gsub("tmb", "det") if rt_movie_object["movies"]
      movie_title = params[:movie]
      @movie = movie_title
      @actors = FreebaseApi.get_movie_cast(movie_title)
    end
  end
end
