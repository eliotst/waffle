class CreateDebriefs < ActiveRecord::Migration
  def change
    create_table :debriefs do |t|
      t.references :user, index: true
      t.string :choice
      t.string :instructor
      t.string :student_name

      t.timestamps
    end
  end
end
