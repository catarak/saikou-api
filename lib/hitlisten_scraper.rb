require 'nokogiri'
require 'open-uri'

class HitlistenScraper

  def initialize
    @country = Country.find_or_create_by(name: "Denmark")
    @chart = Chart.find_or_create_by(name: "Hitlisten", country_id: @country.id)
    parse
  end

  def parse
    @years = (2001..2014)
    @week_nums = (1..53)
    # @years = [2009, 2013, 2014]
    # @week_nums = [47, 52, 53]

    base_url = "http://www.hitlisten.nu/default.asp?w=&y=&list=a40"

    @years.each do |year_num|
      yeared_url = base_url.gsub('y=', "y=#{year_num}")
      @week_nums.each do |week_num|
        if !(week_num == 52 && year_num == 2014)
          url = yeared_url.gsub('w=', "w=#{week_num}")
          doc = Nokogiri::HTML(open(url))

          if doc.css("div#linien:first div#artistnavn").text.length > 0
            year = Year.find_or_create_by(number: year_num)
            week = Week.find_or_create_by(number: week_num - 1, year_id: year.id)
            
            artist_name = doc.css("div#linien:first div#artistnavn").text.strip
            artist = Artist.find_or_create_by(name: artist_name)
        
            title = doc.css("div#linien:first div#titel").text.strip
            song = Song.find_or_create_by(name: title, artist_id: artist.id)

            Record.create(chart_id: @chart.id, week_id: week.id, song_id: song.id)
          end
        end
      end
    end
  end

end

