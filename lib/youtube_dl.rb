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

  def output
    @output ||=
      Rails.root.join('tmp', 'youtube-dl', "#{Digest::MD5.hexdigest(url)}.mp3")
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

  private

  def command
    <<~SHELL
      youtube-dl \
        --extract-audio \
        --audio-format mp3 \
        --print-json \
        --output #{output} \
        #{url}
    SHELL
  end
end
