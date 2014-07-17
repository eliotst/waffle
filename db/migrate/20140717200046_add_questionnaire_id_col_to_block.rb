class AddQuestionnaireIdColToBlock < ActiveRecord::Migration
  def change
    add_column :blocks, :questionnaire_id, :integer
  end
end
