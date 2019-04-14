class PodcastDecorator < ApplicationDecorator
  def episodes_count
    t('counts.episodes', count: episodes.count)
  end
end
