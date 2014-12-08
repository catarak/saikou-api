class CreateWeekCountries < ActiveRecord::Migration
  def change
    create_table :week_countries do |t|
      t.references :week, index: true
      t.references :country, index: true

      t.timestamps null: false
    end
  end
end
