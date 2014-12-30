class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :label

      t.timestamps
    end
  end
end
