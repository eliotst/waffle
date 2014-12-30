class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.datetime :time_to_send
      t.boolean :sent
      t.references :participant, index: true
      t.references :schedule, index: true
      t.references :questionnaire, index: true

      t.timestamps
    end
  end
end
