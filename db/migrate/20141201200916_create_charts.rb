class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :name
      t.references :country, index: true

      t.timestamps null: false
    end
  end
end
