class Api::V1::SongsController < ApplicationController
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
