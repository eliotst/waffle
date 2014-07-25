class AddStudyIdColToQuestionnaire < ActiveRecord::Migration
  def change
    add_column :questionnaires, :study_id, :integer
  end
end
