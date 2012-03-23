class AddRatingColumnToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :rating, :integer, :null => false, :default => 0

  end
end
