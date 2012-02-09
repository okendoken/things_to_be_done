class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.references :user

      t.timestamps
    end
    add_index :problems, :user_id
  end
end
