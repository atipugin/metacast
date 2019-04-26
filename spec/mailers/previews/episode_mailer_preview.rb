class EpisodeMailerPreview < ActionMailer::Preview
  def episode_processed
    EpisodeMailer.episode_processed(Episode.processed.last)
  end
end
