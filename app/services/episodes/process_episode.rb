module Episodes
  class ProcessEpisode < ApplicationService
    attr_accessor :episode

    validates :episode, presence: true

    def perform
      episode.process!
    end
  end
end
