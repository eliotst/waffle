class CreateScheduleTemplateEntries < ActiveRecord::Migration
  def change
    create_table :schedule_template_entries do |t|
      t.integer :time_offset_hours
      t.references :schedule_template, index: true
      t.references :questionnaire, index: true

      t.timestamps
    end
  end
end
