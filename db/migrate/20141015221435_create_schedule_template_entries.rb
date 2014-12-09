class CreateScheduleTemplateEntries < ActiveRecord::Migration
  def change
    create_table :schedule_template_entries do |t|
      t.references :schedule_template_id, index: true
      t.references :questionnaire_id, index: true
      t.references :participant_id, index: true
      t.integer :time_offset_hours
      t.boolean :sent

      t.timestamps
    end
  end
end

