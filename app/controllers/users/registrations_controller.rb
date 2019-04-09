module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do
        Podcasts::CreateExample.run!(user: resource) if resource.persisted?
      end
    end
  end
end
