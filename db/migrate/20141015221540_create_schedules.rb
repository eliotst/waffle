class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :participant_id, index: true
      t.references :schedule_template_id, index: true
      t.integer :start_time_epoch_seconds

      t.timestamps
    end
  end
end
