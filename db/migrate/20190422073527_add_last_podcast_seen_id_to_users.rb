class AddLastPodcastSeenIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_podcast_seen_id, :integer
  end
end
