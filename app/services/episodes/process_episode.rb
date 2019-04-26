require 'youtube_dl'

module Episodes
  class ProcessEpisode < ApplicationService
    attr_accessor :episode

    validates :episode, presence: true

    after_perform :remove_audio_file, if: :audio_file?
    after_perform :send_email_notification, if: -> { episode.processed? }

    def perform
      youtube_dl.run!
      episode.assign_attributes(attributes)
      episode.process
      episode.save!
    rescue YoutubeDl::Error => e
      Raven.capture_exception(e)
      episode.fail!
    end

    private

    def youtube_dl
      @youtube_dl ||= YoutubeDl.new(episode.source_url)
    end

    def attributes
      {
        audio: audio_file,
        remote_image_url: youtube_dl.image_url,
        title: youtube_dl.title,
        description: youtube_dl.description,
        author: youtube_dl.author,
        duration: youtube_dl.duration
      }
    end

    def remove_audio_file
      FileUtils.remove(youtube_dl.audio_path)
    end

    def audio_file
      File.open(youtube_dl.audio_path) if audio_file?
    end

    def audio_file?
      File.exist?(youtube_dl.audio_path)
    end

    def send_email_notification
      EpisodeMailer.episode_processed(episode).deliver_later
    end
  end
end
