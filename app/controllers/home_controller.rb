class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to last_podcast ? podcast_path(last_podcast) : podcasts_path
  end

  private

  def last_podcast
    @last_podcast ||= last_seen_podcast || current_user.podcasts.last
  end

  def last_seen_podcast
    return unless session[:last_seen_podcast_id]

    current_user.podcasts.find_by(id: session.delete(:last_seen_podcast_id))
  end
end
