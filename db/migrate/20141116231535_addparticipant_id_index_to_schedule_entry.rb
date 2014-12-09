class AddparticipantIdIndexToScheduleEntry < ActiveRecord::Migration
  def change
    add_index :schedule_entries, :participant_id
    add_index :schedule_entries, :schedule_template_id
    add_index :schedule_entries, :questionnaire_id
  end
end
