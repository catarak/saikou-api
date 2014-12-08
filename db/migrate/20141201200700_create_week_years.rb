class CreateWeekYears < ActiveRecord::Migration
  def change
    create_table :week_years do |t|
      t.references :week, index: true
      t.references :year, index: true

      t.timestamps null: false
    end
  end
end
