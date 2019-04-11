# See: https://github.com/simplepie/simplepie-ng/wiki/Spec:-iTunes-Podcast-RSS
xml.instruct!
xml.rss version: '2.0', 'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd' do
  xml.channel do
    xml.title @podcast.title
    xml.link podcast_url(@podcast)
    xml.tag! 'itunes:image', href: @podcast.image_url(:itunes)

    @podcast.episodes.processed.each do |episode|
      xml.item do
        xml.title episode.title
        xml.tag! 'itunes:author', episode.author
        xml.tag! 'itunes:summary' do
          xml.cdata! episode.description
        end
        xml.tag! 'itunes:image', href: episode.image_url(:itunes)
        xml.enclosure url: episode.audio_url, type: episode.audio_content_type, length: episode.audio_size
        xml.guid episode_url(episode)
        xml.pubDate episode.created_at.rfc2822
        xml.tag! 'itunes:duration', Time.at(episode.duration).utc.strftime('%H:%M:%S')
      end
    end
  end
end
