class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.references :artist, index: true

      t.timestamps null: false
    end
  end
end
