class LosequestIdFromBlocks < ActiveRecord::Migration
  def change
    remove_column :blocks, :question_id
  end
end