require 'open-uri'

class JpOriconScraper

  def initialize
    @country = Country.find_or_create_by(name: "Japan")
    @chart = @country.charts.find_or_create_by(name: "Oricon", country_id: @country.id)
  end

  def scrape
    @date = date_of_recent("Monday")
    @end_date = Date.new(2005,10,10)
    while @date > @end_date
      parse_oricon_page
      @date = @date - 7.days
    end
  end

  def parse_oricon_page
    begin 
      #Creating date instances
      url = "http://www.oricon.co.jp/rank/js/w/#{@date.to_s}/"
      doc = Nokogiri::HTML(open(url))
      @artist_name = doc.at_css('.mb20+ .box-rank-entry .name').text.strip
      @song_name = doc.at_css('.mb20+ .box-rank-entry .title').text.strip
      
      #Finding accurate date from page and normalizing
      symbol_replace = {"年" => "","月" => "", "日" => "", "）" => ""}
      @db_date = doc.at_css('.date').text.strip.split("〜").second
      @db_date = Date.parse(@db_date.gsub(/./) { |m| symbol_replace.fetch(m,m) } )
    rescue OpenURI::HTTPError => the_error
      @db_date = @db_date - 7.days
    rescue Exception => e  
      @date = @date + 7.days
    end
    
    #Creating the year and week
    year = Year.find_or_create_by(number: @db_date.year)
    week = year.weeks.find_or_create_by(number: @db_date.strftime('%W').to_i)

    #Creating artist, song, and record
    artist = Artist.find_or_create_by(name: @artist_name)
    song = artist.songs.find_or_create_by(name: @song_name)
    record = Record.create(week_id: week.id, song_id: song.id, chart_id: @chart.id)
  end

  private

  def date_of_recent(day)
    date  = Date.parse(day)
    delta = date > Date.today ? 0 : 7
    date - delta
  end

end