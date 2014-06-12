class AddValidTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :valid_token, :string
  end
end
