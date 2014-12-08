class DropTableSongCharts < ActiveRecord::Migration
  def change
    drop_table :song_charts
  end
end
