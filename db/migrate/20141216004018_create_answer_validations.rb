class CreateAnswerValidations < ActiveRecord::Migration
  def change
    create_table :answer_validations do |t|
      t.string :regular_expression, default: /.*/
      t.references :answer_type, index: true

      t.timestamps
    end
  end
end
