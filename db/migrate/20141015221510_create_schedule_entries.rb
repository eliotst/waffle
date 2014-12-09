class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.references :participant_id, index: true
      t.references :schedule_template_id, index: true
      t.references :questionnaire_id, index: true
      t.string :time_to_send
      t.boolean :sent

      t.timestamps
    end
  end
end
