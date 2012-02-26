class AddAttachmentAvatarToUserInfo < ActiveRecord::Migration
  def self.up
    add_column :user_infos, :avatar_file_name, :string
    add_column :user_infos, :avatar_content_type, :string
    add_column :user_infos, :avatar_file_size, :integer
    add_column :user_infos, :avatar_updated_at, :datetime
    remove_column :user_infos, :avatar_url
  end

  def self.down
    remove_column :user_infos, :avatar_file_name
    remove_column :user_infos, :avatar_content_type
    remove_column :user_infos, :avatar_file_size
    remove_column :user_infos, :avatar_updated_at
    add_column :user_infos, :avatar_url
  end
end
