class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :value

      t.timestamps
    end
  end
end
