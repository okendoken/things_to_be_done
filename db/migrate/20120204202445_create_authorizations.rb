class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :name
      t.string :link
      t.references :user

      t.timestamps
    end
    add_index :authorizations, :user_id
  end
end
