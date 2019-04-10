class EpisodesController < ApplicationController
  before_action :authenticate_user!

  def show
    render nothing: true
  end

  def destroy
    episode = Episode.find(params[:id])
    authorize(episode)
    episode.destroy
    redirect_to podcast_path(episode.podcast), notice: t('.notice')
  end
end
