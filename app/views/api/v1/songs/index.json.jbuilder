json.countries @countries do |country|
  json.name country.name
  json.charts country.charts do |chart|
    json.name chart.name
    record = @records.find_by(chart_id: chart.id)
    json.set! :song do
      json.name Song.joins(:records).find_by(records: {id: record.id}).name
      json.artist Song.joins(:records).find_by(records: {id: record.id}).artist.name
    end
  end
end 