class AddstudyIdColToScheduleTemplate < ActiveRecord::Migration
  def change
    add_column :schedule_templates, :study_id, :integer
  end
end
