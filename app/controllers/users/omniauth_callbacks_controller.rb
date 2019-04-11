module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def all # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      auth = request.env['omniauth.auth']
      if user_signed_in?
        attach_authentication_to_user(current_user, auth)
        redirect_back fallback_location: root_path
      else
        user = User.from_omniauth(auth)
        if user.persisted?
          attach_authentication_to_user(user, auth)
          sign_in_and_redirect user, event: :authentication
        else
          session['devise.auth_data'] = auth
          redirect_to new_user_registration_path
        end
      end
    end
    alias google_oauth2 all

    private

    def attach_authentication_to_user(user, auth)
      user
        .authentications
        .where(provider: auth.provider, uid: auth.uid)
        .first_or_create(auth_data: auth)
    end
  end
end
