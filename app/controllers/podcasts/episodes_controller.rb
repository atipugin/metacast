module Podcasts
  class EpisodesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_podcast
    before_action :authorize_podcast

    def create # rubocop:disable Metrics/AbcSize
      authorize(Episode)
      episode = @podcast.episodes.new(episode_params)
      if episode.save
        Episodes::ProcessEpisodeWorker.perform_async(episode.id)
        flash[:notice] = t('.notice')
      else
        flash[:alert] = episode.errors.full_messages.first
      end

      redirect_to podcast_path(@podcast)
    end

    private

    def find_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end

    def authorize_podcast
      authorize(@podcast, :show?)
    end

    def episode_params
      params.require(:episode).permit(:source_url)
    end
  end
end
