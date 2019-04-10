require 'open3'

class YoutubeDl
  class Error < StandardError; end

  attr_reader :url

  def initialize(url)
    @url = url
    @data = {}
  end

  def run!
    stdout, stderr, status = Open3.capture3(command)
    raise Error, stderr if status.exitstatus.nonzero?

    @data = JSON.parse(stdout)
  end

  def audio_path
    audio_dir.join("#{audio_name}.#{extension}")
  end

  def image_url
    @data['thumbnail']
  end

  def title
    @data['title']
  end

  def description
    @data['description']
  end

  def author
    @data['uploader']
  end

  def duration
    @data['duration']
  end

  private

  def command
    <<~SHELL
    youtube-dl \
      --extract-audio \
      --audio-format #{extension} \
      --print-json \
      --output \'#{audio_dir.join(audio_name)}.%(ext)s\' \
      #{url}
    SHELL
  end

  def extension
    :mp3
  end

  def audio_dir
    @audio_dir ||= Rails.root.join('tmp', 'youtube-dl')
  end

  def audio_name
    @audio_name ||= Digest::MD5.hexdigest(url)
  end
end
