class FixColumnName2 < ActiveRecord::Migration
  def change
  	rename_table :blocks, :block
  end
end
