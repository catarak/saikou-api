class DropTableWeekYears < ActiveRecord::Migration
  def change
    drop_table :week_years
  end
end
