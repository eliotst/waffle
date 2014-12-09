class CreateScheduleTemplates < ActiveRecord::Migration
  def change
    create_table :schedule_templates do |t|
      t.references :participant_id, index: true

      t.timestamps
    end
  end
end
