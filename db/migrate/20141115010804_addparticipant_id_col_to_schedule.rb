class AddparticipantIdColToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :participant_id, :integer
    add_column :schedules, :schedule_template_id, :integer
  end
end
