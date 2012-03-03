class AddNicknameColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string, :null => false, :default => ""

  end
end
