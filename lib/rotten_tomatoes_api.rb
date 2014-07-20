class RottenTomatoesApi
  def self.search(search_string)
    search_results = HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{ENV['ROTTEN_TOMATOES_KEY']}&q=#{URI.escape(search_string)}&page_limit=3", :format => :json)
    if search_results.has_key?("movies")
      search_results
    end
  end

  def self.get_movie(movie_id)
    HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/movies/#{movie_id}.json?apikey=#{ENV['ROTTEN_TOMATOES_KEY']}", :format => :json)
  end

  def self.get_movie_cast(movie_id)
    HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/movies/#{movie_id}/cast.json?apikey=#{ENV['ROTTEN_TOMATOES_KEY']}", :format => :json)
  end

  def self.seed_search(search_string)
    self.search(search_string)["movies"].collect do |movie|
      Movie.create_from_rotten(movie)
    end
  end
end