class AddStatusColumnToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :status, :integer, :null => false, :default => PARTICIPATION_STATUS[:in_progress]

  end
end
