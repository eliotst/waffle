class CreateScheduleTemplates < ActiveRecord::Migration
  def change
    create_table :schedule_templates do |t|
      t.integer :study_id

      t.timestamps
    end
  end
end
