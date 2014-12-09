class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :label
      t.integer :block_id
      t.references :answer_type_id, index: true

      t.timestamps
    end
  end
end
