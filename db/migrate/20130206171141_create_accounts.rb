class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :phone_number
      t.string :activation_code, :length => 5 
      t.datetime :activated_at
      t.string :auth_token
      t.timestamps
    end
  end
end
