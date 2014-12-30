class CreateAnswerTypes < ActiveRecord::Migration
  def change
    create_table :answer_types do |t|
      t.string :label
      t.string :description

      t.timestamps
    end
  end
end
