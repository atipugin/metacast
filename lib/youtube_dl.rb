require 'open3'

class YoutubeDl
  class Error < StandardError; end

  attr_reader :url, :output

  def initialize(url:, output:)
    @url = url
    @output = output
    @data = {}
  end

  def run!
    stdout, stderr, status = Open3.capture3(command)
    raise Error, stderr if status.exitstatus.nonzero?

    @data = JSON.parse(stdout)
  end

  def image_url
    @data['thumbnail']
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
