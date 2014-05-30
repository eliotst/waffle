class AddAddressLineOneToUser < ActiveRecord::Migration
  def change
    add_column :users, :address_line_one, :string
  end
end
