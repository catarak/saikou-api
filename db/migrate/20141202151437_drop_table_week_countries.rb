class DropTableWeekCountries < ActiveRecord::Migration
  def change
    drop_table :week_countries
  end
end
