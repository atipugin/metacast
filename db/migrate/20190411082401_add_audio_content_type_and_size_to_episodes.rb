class AddAudioContentTypeAndSizeToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :audio_content_type, :string
    add_column :episodes, :audio_size, :integer
  end
end
