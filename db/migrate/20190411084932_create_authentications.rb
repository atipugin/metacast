class CreateAuthentications < ActiveRecord::Migration[5.2]
  def change
    create_table :authentications do |t|
      t.timestamps
      t.references :user, foreign_key: true, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.jsonb :auth_data, null: false, default: {}
    end

    add_index :authentications, %i[user_id provider uid], unique: true
  end
end
