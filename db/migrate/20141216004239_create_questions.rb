class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :label
      t.references :block, index: true
      t.references :answer_type, index: true

      t.timestamps
    end
  end
end
