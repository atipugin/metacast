module Podcasts
  class CreateExample < ApplicationService
    attr_accessor :user

    validates :user, presence: true

    def perform
      user.podcasts.create(title: title)
    end

    private

    def title
      I18n.t('podcasts.example_title', name: user.name)
    end
  end
end
