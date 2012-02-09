class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.references :problem
      t.references :user

      t.timestamps
    end
    add_index :projects, :user_id
    add_index :projects, :problem_id
  end
end
