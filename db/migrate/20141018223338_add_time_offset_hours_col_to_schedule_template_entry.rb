class AddTimeOffsetHoursColToScheduleTemplateEntry < ActiveRecord::Migration
  def change
    add_column :schedule_template_entries, :time_offset_hours, :integer
    add_column :schedule_template_entries, :sent, :boolean
  end
end
