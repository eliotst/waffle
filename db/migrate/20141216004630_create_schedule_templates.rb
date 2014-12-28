class CreateScheduleTemplates < ActiveRecord::Migration
  def change
    create_table :schedule_templates do |t|
      t.references :study, index: true

      t.timestamps
    end
  end
end
