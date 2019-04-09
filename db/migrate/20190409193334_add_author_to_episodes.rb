class AddAuthorToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :author, :string
  end
end
