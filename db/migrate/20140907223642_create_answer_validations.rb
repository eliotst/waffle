class CreateAnswerValidations < ActiveRecord::Migration
  def change
    create_table :answer_validations do |t|
      t.string :regular_expression
      t.references :answer_type

      t.timestamps
    end
  end
end
