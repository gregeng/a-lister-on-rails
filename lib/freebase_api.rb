class FreebaseApi

FREEBASE_URL = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')

  def self.get_actor_movies(actor="Brad Pitt")
    query = [
          {
            "starring" => [ { "actor" => actor } ],
            "name" => [],
            "type" => "/film/film"
          }
        ]

    response = query_freebase(query)
    movies = response['result'].collect { |movie| movie['name'] }
    movies.flatten
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

    response = query_freebase(query)
  end

  def self.get_movie_cast(movie="Ocean's Eleven")
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

      response = query_freebase(query)
      actors = response['result'][0]['starring'].collect { |name| name['actor'] }
      actors.flatten
  end

  private

  def self.query_freebase(query)
    FREEBASE_URL.query_values = {
        'query' => query.to_json,
        'key'=> ENV['FREEBASE_KEY']
      }

    HTTParty.get(FREEBASE_URL, :format => :json)
  end

end
