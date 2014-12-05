class CreateBlockQuestionnaires < ActiveRecord::Migration
  def change
    create_table :block_questionnaires do |t|
      t.references :block, index: true
      t.references :questionnaire, index: true

      t.timestamps
    end
  end
end
