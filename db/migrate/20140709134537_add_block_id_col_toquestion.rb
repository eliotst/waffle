class AddBlockIdColToquestion < ActiveRecord::Migration
  def self.up 
  	add_column :questions, :block_id, :integer
  end
end
