class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :value
      t.references :answer_set, index: true
      t.references :participant, index: true
      t.references :question, index: true

      t.timestamps
    end
  end
end
