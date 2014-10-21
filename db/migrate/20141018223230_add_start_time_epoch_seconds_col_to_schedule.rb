class AddStartTimeEpochSecondsColToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :start_time_epoch_seconds, :integer
  end
end
