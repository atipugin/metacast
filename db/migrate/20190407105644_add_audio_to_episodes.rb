class AddAudioToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :audio, :string
  end
end
