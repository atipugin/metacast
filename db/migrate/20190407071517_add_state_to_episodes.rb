class AddStateToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :state, :string, null: false
  end
end
