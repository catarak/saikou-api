class Api::V1::SongsController < ApplicationController

  ##
  # Returns number one hit songs for all countries/charts on a given week within a year. 
  #
  # GET /api/v1/years/:year_number/weeks/:weeks_number/songs
  #
  #
  # = Examples
  #
  #   resp = conn.get("/api/v1/years/2014/weeks/48/songs")
  #
  #   resp.status
  #   => 200
  #
  #   resp.body
  #   => {"countries":[{"name":"United States","charts":[{"name":"Billboard","song":{"name":"Blank Space","artist":"Taylor Swift"}}]},
  #      {"name":"United Kingdom","charts":[{"name":"Official Charts","song":{"name":"THESE DAYS","artist":"TAKE THAT"}}]}]}
  #
  #   resp = conn.get("/api/v1/years/3000/weeks/0/songs")
  #
  #   resp.status
  #   => 404
  #
  #   resp.body
  #   => {"message": "Resource not found"}
  #

  def index
    @year = Year.find_by(number: params[:year_number].to_i)
    if @year.nil?
      render json: {message: 'Resource not found'}, status: 404
    else
      @week = Week.find_by(number: params[:week_number].to_i, year_id: @year.id)
      if @week.nil? 
        render json: {message: 'Resource not found'}, status: 404
      else
        @records = Record.where(week_id: @week.id)
        @countries = Country.joins(charts: :records).where(records: {week_id: @week.id})
      end
    end
  end
end
