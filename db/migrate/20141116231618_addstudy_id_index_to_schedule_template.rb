class AddstudyIdIndexToScheduleTemplate < ActiveRecord::Migration
  def change
    add_index :schedule_templates, :study_id
  end
end
