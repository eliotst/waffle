class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :value
      t.string :text
      t.integer :order
      t.references :answer_type, index: true

      t.timestamps
    end
  end
end
