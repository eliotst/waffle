class AddscheduleTemplateIdIndexToScheduleTemplateEntry < ActiveRecord::Migration
  def change
    add_index :schedule_template_entries, :schedule_template_id
    add_index :schedule_template_entries, :questionnaire_id
  end
end
