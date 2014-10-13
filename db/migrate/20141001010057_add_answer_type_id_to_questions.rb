class AddAnswerTypeIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :answer_type_id, :integer
    add_index :questions, :answer_type_id
  end
end
