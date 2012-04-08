class AddCityColumnToProject < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.references :city
    end
    add_index :projects, :city_id

  end
end
