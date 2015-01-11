class CreateAnswerSets < ActiveRecord::Migration
  def change
    create_table :answer_sets do |t|
      t.references :questionnaire, index: true
      t.references :participant, index: true

      t.timestamps
    end
  end
end
