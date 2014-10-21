class AddTimeToSendColToScheduleEntry < ActiveRecord::Migration
  def change
    add_column :schedule_entries, :time_to_send, :string
    add_column :schedule_entries, :sent, :boolean
  end
end
