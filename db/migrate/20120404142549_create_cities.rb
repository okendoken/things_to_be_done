class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.references :country
      t.string :slug
    end
    add_index :cities, :country_id
    add_index :cities, :slug, :unique => true
  end
end
