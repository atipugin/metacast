module Episodes
  class ProcessEpisodeWorker
    include Sidekiq::Worker

    sidekiq_options queue: 'episodes'

    def perform(episode_id)
      Episodes::ProcessEpisode.run!(episode: Episode.find(episode_id))
    end
  end
end
