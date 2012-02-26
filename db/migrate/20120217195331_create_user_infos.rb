class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.string :gender
      t.string :occupation
      t.string :birth_date
      t.text :about_myself
      t.references :user
      t.string :avatar_url

      t.timestamps
    end
  end
end
