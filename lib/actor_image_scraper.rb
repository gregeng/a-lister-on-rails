class ActorImageScraper

  ROTTENTOMATOES_ACTOR_LINK = "http://www.rottentomatoes.com/celebrity/"

  def self.scrape_actor_image(actor_name)
    sanitized_actor_name = sanitize_actor_name(actor_name)
    url = build_actor_url(sanitized_actor_name)
    site_data = open_actor_page(url)
    scrape_image(site_data)
  end

  private

  def self.sanitize_actor_name(actor_name)
    actor_name.downcase.strip.gsub(" ","_").gsub(".","")
  end

  def self.build_actor_url(sanitized_actor_name)
    ROTTENTOMATOES_ACTOR_LINK + sanitized_actor_name
  end

  def self.open_actor_page(url)
    begin
      site_data = Nokogiri::HTML(open(url))
    rescue
      puts "This person isn't on RottenTomatoes and hence... is not an A-Lister!"
    end
  end

  def self.scrape_image(site_data)
    begin
      site_data.css("div.media_block_image img").attr('src').value
    rescue
      # Set to a default picture, maybe the 2 actors mask
      "http://www.mymusclesinmotion.com/wp-content/uploads/headshot-placeholder.gif"
    end
  end

end