class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.string :slug
    end

    add_index :countries, :slug, :unique => true
  end
end
