class AddImageToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :image, :string
  end
end
