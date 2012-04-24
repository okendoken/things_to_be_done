class AddAvatarToProjectAndTask < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.has_attached_file :avatar
    end
    change_table :tasks do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :tasks, :avatar
    drop_attached_file :projects, :avatar
  end
end
