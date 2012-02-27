class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.text :about_myself
      t.references :user

      t.timestamps
    end
  end
end
