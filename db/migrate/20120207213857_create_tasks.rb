class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status, :null => false, :default => TASK_STATUS[:in_progress]
      t.references :user
      t.references :project

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :project_id
  end
end
