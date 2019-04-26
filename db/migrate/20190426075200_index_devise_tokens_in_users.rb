class IndexDeviseTokensInUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
  end
end
