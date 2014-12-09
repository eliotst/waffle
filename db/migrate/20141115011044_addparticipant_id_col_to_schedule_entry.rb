class AddparticipantIdColToScheduleEntry < ActiveRecord::Migration
  def change
    add_column :schedule_entries, :participant_id, :integer
    add_column :schedule_entries, :schedule_template_id, :integer
    add_column :schedule_entries, :questionnaire_id, :integer
  end
end
