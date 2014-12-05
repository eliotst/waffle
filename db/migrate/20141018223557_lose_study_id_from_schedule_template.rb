class LoseStudyIdFromScheduleTemplate < ActiveRecord::Migration
  def change
    remove_column :schedule_templates, :study_id
  end
end
