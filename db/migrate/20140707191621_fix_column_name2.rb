class FixColumnName2 < ActiveRecord::Migration
  def change
  	rename_table :block, :blocks
  end
end
