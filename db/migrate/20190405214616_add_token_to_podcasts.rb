class AddTokenToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :token, :string, null: false
    add_index :podcasts, :token, unique: true
  end
end
