module RSS
  class PodcastsController < ApplicationController
    skip_after_action :verify_authorized

    def show
      @podcast = Podcast.find_by!(token: params[:id])
    end
  end
end
