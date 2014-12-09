class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :new
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.boolean :is_valid
      t.string :valid_token
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :name
      t.references :auth_token, index: true
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
