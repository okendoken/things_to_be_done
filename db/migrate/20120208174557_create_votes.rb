class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :positive
      t.references :project
      t.references :user

      t.timestamps
    end
    add_index :votes, :project_id
    add_index :votes, :user_id
  end
end
