class EpisodeMailer < ApplicationMailer
  def episode_processed(episode)
    @episode = episode
    mail(to: @episode.podcast.user.email, subject: t('.subject'))
  end
end
