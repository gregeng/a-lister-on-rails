class FreebaseApi

FREEBASE_URL = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')

  def self.freebase_magic(query)
    FREEBASE_URL.query_values = {
        'query' => query.to_json,
        'key'=> ENV['FREEBASE_KEY']
      }

    HTTParty.get(FREEBASE_URL, :format => :json)
  end

  def self.get_actor_details(actor="Brad Pitt")
    query = [
      {
        "netflix_id" => nil,
        "imdb_entry" => nil,
        "name" => actor,
        "type" => "/film/actor"
      }
    ]

    response = freebase_magic(query)
  end

  def self.show_movies(actor="Brad Pitt")
    query = [
          {
            "starring" => [ { "actor" => actor } ],
            "name" => [],
            "type" => "/film/film"
          }
        ]

    response = freebase_magic(query)
    # movies = response['result'].collect { |movie| movie['name'] }
    # movies.flatten
  end

  def self.show_actors(movie="Ocean's Eleven")
    query = [
          {
            "starring" => [ {"actor" => [] } ],
            "name" => movie,
            "netflix_id" => [],
            "type" => "/film/film",
            "imdb_id" => [],
            "netflix_id" => [],
            "rottentomatoes_id" => [],
            "trailers" => []
          }
        ]

      response = freebase_magic(query)
      # actors = response['result'][0]['starring'].collect { |name| name['actor'] }
      # actors.flatten
  end

  def self.check_actor_answer(actor="Brad Pitt", movie="Fight Club")
    movies = show_movies(actor)
    movies.include?(movie)
  end

  def self.check_movie_answer(movie="Fight Club", actor="Brad Pitt")
    actors = show_actors(movie)
    actors.include?(actor)
  end

end
