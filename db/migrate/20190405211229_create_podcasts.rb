class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.timestamps
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false
    end
  end
end
