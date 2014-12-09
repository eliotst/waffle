class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.string :label
      t.references :study_id, index: true

      t.timestamps
    end
  end
end
