class AddscheduleTemplateIdColToScheduleTemplateEntry < ActiveRecord::Migration
  def change
    add_column :schedule_template_entries, :schedule_template_id, :integer
    add_column :schedule_template_entries, :questionnaire_id, :integer
  end
end
