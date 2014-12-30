class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.references :participant, index: true
      t.references :schedule_template, index: true

      t.timestamps
    end
  end
end
