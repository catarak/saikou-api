require 'nokogiri'
require 'open-uri'

class MusiclineScraper

  def initialize
    @country = Country.find_or_create_by(name: "Germany")
    @chart = Chart.find_or_create_by(name: "musicline", country_id: @country.id)
    parse
  end

  def parse
    @years = (1959..2014)
    @week_nums = (1..53)
    # @years = (2013..2014)
    # @week_nums = [47, 50]

    base_url = "http://www.musicline.de/de/charts/single?page=0&week=&year="

    @years.each do |year_num|
      yeared_url = base_url.gsub('year=', "year=#{year_num}")
      @week_nums.each do |week_num|
        url = yeared_url.gsub('week=', "week=#{week_num}")
        doc = Nokogiri::HTML(open(url))

        if doc.css("tr:nth-child(2) .chart-position.artist-right p a").text.length > 0
          year = Year.find_or_create_by(number: year_num)
          week = Week.find_or_create_by(number: week_num - 1, year_id: year.id)

          artist_name = doc.css("tr:nth-child(2) .chart-position.artist-right p a").text.strip
          artist = Artist.find_or_create_by(name: artist_name)
        
          title = doc.css("tr:nth-child(2) .chart-position.titel p a").text.strip
          song = Song.find_or_create_by(name: title, artist_id: artist.id)

          Record.create(chart_id: @chart.id, week_id: week.id, song_id: song.id)
        end
      end
    end
  end

end


