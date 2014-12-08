class CreateChartWeeks < ActiveRecord::Migration
  def change
    create_table :chart_weeks do |t|
      t.references :chart, index: true
      t.references :week, index: true

      t.timestamps null: false
    end
  end
end
