require 'date'
require 'open-uri'

class EmaScraper

  def initialize
    @country = Country.find_or_create_by(name: "South Africa")
    @chart = Chart.find_or_create_by(name: "EMA", country_id: @country.id)
    date_maker
  end

  def date_decrementer
    @date = week_ending("Tuesday")
    while @scraping == true
      parse
      @date = @date - 7.days
    end
  end

  def parse
    url = "http://www.sa-ema.com/index.php/charts-board/?week=#{@date.to_s}"
    doc = Nokogiri::HTML(open(url))
    
    if doc.css("li:first .date").text.length == 0
      @scraping = false

    artist_name = doc.css('li:first .date').text.strip
    artist = Artist.find_or_create_by(name: artist_name)

    song_name = doc.css('li:first .location').text.strip
    song = artist.songs.find_or_create_by(name: song_name)

    year_num = @date.to_s[0..3]
    year = Year.find_or_create_by(number: year_num)

    week_num = @date.strftime('%W').to_i
    week = year.weeks.find_or_create_by(number: week_num)

    Record.create(chart_id: @chart.id, week_id: week.id, song_id: song.id)
    end
  end

  private
    def week_ending(day)
      date  = Date.parse(day)
      delta = date > Date.today ? 0 : 7
      date - delta
    end

end

