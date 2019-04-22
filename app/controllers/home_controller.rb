class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    path =
      if current_user.last_podcast_seen_id?
        podcast_path(current_user.last_podcast_seen)
      else
        podcasts_path
      end

    redirect_to path
  end
end
