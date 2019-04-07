require 'youtube_dl'

module Episodes
  class ProcessEpisode < ApplicationService
    attr_accessor :episode

    attr_writer :audio_path

    validates :episode, presence: true

    def perform
      youtube_dl.run!

      unless audio_file
        episode.fail!
        return
      end

      episode.assign_attributes(attributes)
      episode.process!
    end

    private

    def youtube_dl
      @youtube_dl ||= YoutubeDl.new(url: episode.source_url, output: audio_path)
    end

    def attributes
      {
        audio: audio_file,
        remote_image_url: youtube_dl.image_url,
        title: youtube_dl.title,
        description: youtube_dl.description
      }
    end

    def audio_file
      File.open(audio_path) if File.exist?(audio_path)
    end

    def audio_path
      @audio_path ||= Rails.root.join(
        'tmp', 'youtube-dl', "#{Digest::MD5.hexdigest(episode.source_url)}.mp3"
      )
    end
  end
end
