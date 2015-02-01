class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :name
      t.boolean :is_admin
      t.boolean :is_valid
      t.string :auth_token
      t.string :valid_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
  end
end
