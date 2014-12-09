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

  desc "Scrape only recent Japan's Oricon charts"
  task :jp_oricon_recent => :environment do
    jp_scraper = JpOriconScraper.new
    jp_scraper.recent_scrape
  end

  desc "Scrape Denmark's Hitlisten charts"
  task :dk_hitlisten => :environment do
    HitlistenScraper.new.parse
  end

  desc "Scrape Denmark's Hitlisten charts for most recent week"
  task :dk_hitlisten_recent => :environment do
    HitlistenScraper.new.recent_parse
  end

  desc "Scrape Germany's Musicline charts"
  task :de_musicline => :environment do
    MusiclineScraper.new.parse
  end

  desc "Scrape Germany's Musicline charts for most recent week"
  task :de_musicline_recent => :environment do
    MusiclineScraper.new.recent_parse
  end

  desc "Scrape UK's Official charts"
  task :uk_official => :environment do
    uk_scraper = UKOfficialChartsScraper.new
    uk_scraper.scrape_all
  end

  desc "Scrape only recent UK's Official charts"
  task :uk_official_recent => :environment do
    uk_scraper = UKOfficialChartsScraper.new
    uk_scraper.scrape_recent
  end


  desc "Scrape all countries"
  task :all => [:us_billboard, :jp_oricon, :dk_hitlisten, :de_musicline, :uk_official]

  desc "Scrape recent music only"
  task :recent => [:us_billboard_recent, :dk_hitlisten_recent, :de_musicline_recent, :uk_official_recent, :jp_oricon_recent]

end