class AddCityColumnToTask < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :city
    end
    add_index :tasks, :city_id

  end
end
