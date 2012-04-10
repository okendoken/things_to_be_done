class AddCityColumnToUserInfo < ActiveRecord::Migration
  def change
    change_table :user_infos do |t|
      t.string :website
      t.references :city
    end
    add_index :user_infos, :city_id

  end
end
