namespace :scrape do

  desc "Scrape US Billboard charts"
  task :us_billboard => :environment do
    us_scraper = UsBillboardScraper.new
    us_scraper.scrape_all
  end

  desc "Scrape only recent US Billboard charts"
  task :us_billboard_recent => :environment do
    us_scraper = UsBillboardScraper.new
    us_scraper.scrape_recent
  end

  desc "Scrape Japan's Oricon charts"
  task :jp_oricon => :environment do
    jp_scraper = JpOriconScraper.new
    jp_scraper.scrape
  end

  desc "Scrape Denmark's Hitlisten charts"
  task :dk_hitlisten => :environment do
    HitlistenScraper.new
  end

  desc "Scrape Germany's Musicline charts"
  task :de_musicline => :environment do
    MusiclineScraper.new
  end

  desc "Scrape UK's Official charts"
  task :uk_official => :environment do
    uk_scraper = UKOfficialChartsScraper.new
    uk_scraper.scrape_all
  end

  desc "Scrape only recent UK's Official charts"
  task :uk_official => :environment do
    uk_scraper = UKOfficialChartsScraper.new
    uk_scraper.scrape_recent
  end



  desc "Scrape all countries"
  task :all => [:us_billboard, :jp_oricon, :dk_hitlisten, :de_musicline, :uk_official]

end