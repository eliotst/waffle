class AddparticipantIdIndexToSchedule < ActiveRecord::Migration
  def change
    add_index :schedules, :participant_id
    add_index :schedules, :schedule_template_id
  end
end
