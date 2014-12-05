class CreateScheduleTemplateEntries < ActiveRecord::Migration
  def change
    create_table :schedule_template_entries do |t|

      t.timestamps
    end
  end
end
