require 'date'
require 'open-uri'

class UKOfficialChartsScraper
  def initialize
    @base_url = "http://www.officialcharts.com/archive-chart/_/1/"
    initialize_models
  end

  def scrape
    current_week = date_of_next("Saturday")
    still_scraping = true
    while (still_scraping) do
      begin
        current_chart = Nokogiri::HTML(open("#{@base_url}#{current_week.strftime("%Y-%m-%d")}"))
        song_name = current_chart.css("td.info div.infoHolder h3").first.text.strip
        artist_name = current_chart.css("td.info div.infoHolder h4").first.text.strip

        #find or create by everything
        year = Year.find_or_create_by(number: current_week.year)
        week = Week.find_or_create_by(number: current_week.strftime("%U").to_i, year_id: year.id)

        artist = Artist.find_or_create_by(name: artist_name)
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id)

        if Record.find_by(week_id: week.id, chart_id: @chart.id, song_id: song.id)
          still_scraping = false
        else 
          Record.create(week_id: week.id, chart_id: @chart.id, song_id: song.id)
        end

        current_week = current_week - 1.week
      rescue OpenURI::HTTPError => the_error
        still_scraping = false
      end
    end

  end

  def initialize_models
    @country = Country.find_or_create_by(name: "United Kingdom")
    @chart = Chart.find_or_create_by(name: "Official Charts", country_id: @country.id)
  end

  private
    def date_of_next(day)
      date  = Date.parse(day)
      delta = date > Date.today ? 0 : 7
      date + delta
    end

    def normalize_name(name)
      name.downcase.split(" ").map(&:capitalize).join(" ")
    end
end