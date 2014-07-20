class ImdbActorImageScraper
  IMDB_BASE_ACTOR_LINK = "http://www.imdb.com/name/"

  def self.scrape_actor_image(imdb_id)
    url = build_imdb_url(imdb_id)
    site_data = open_movie_page(url)
    scrape_image(site_data)
  end

  private

  def self.build_imdb_url(imdb_id)
    IMDB_BASE_ACTOR_LINK + imdb_id
  end

  def self.open_movie_page(url)
    begin
      site_data = Nokogiri::HTML(open(url))
    rescue
      puts "Actor not found on IMDB, not an A-lister"
    end
  end

  def self.scrape_image(site_data)
    begin
      site_data.css("div.image img").attr('src').value
    rescue
      # Set to a default picture, maybe the 2 actors mask
      "http://www.mymusclesinmotion.com/wp-content/uploads/headshot-placeholder.gif"
    end
  end

end