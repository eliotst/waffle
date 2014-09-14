class AddStudyIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :study_id, :integer
    add_index :participants, :study_id
  end
end
