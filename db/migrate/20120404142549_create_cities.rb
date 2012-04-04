class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.references :country
    end
    add_index :cities, :country_id
  end
end
