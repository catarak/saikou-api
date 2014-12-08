class RenameChartWeeksRecords < ActiveRecord::Migration
  def change
    rename_table :chart_weeks, :records
    add_column :records, :song_id, :integer
  end
end
