class CreateAnswerTypes < ActiveRecord::Migration
  def change
    create_table :answer_types do |t|
      t.string :label
      t.string :description
      t.references :study, index: true
      t.boolean :allow_multiple, default: false

      t.timestamps
    end
  end
end
