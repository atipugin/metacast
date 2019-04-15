class EpisodeDecorator < ApplicationDecorator
  def title
    object.title || t('none.title')
  end

  def author
    object.author || t('none.author')
  end
end
