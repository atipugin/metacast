class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.timestamps
      t.references :podcast, foreign_key: true, null: false
      t.string :source_url, null: false
    end
  end
end
