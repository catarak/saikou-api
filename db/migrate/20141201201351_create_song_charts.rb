class CreateSongCharts < ActiveRecord::Migration
  def change
    create_table :song_charts do |t|
      t.references :song, index: true
      t.references :chart, index: true

      t.timestamps null: false
    end
  end
end
