class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :is_verified, :is_valid
  end
end
