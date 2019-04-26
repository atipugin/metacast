# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           not null
#  encrypted_password     :string           not null
#  last_podcast_seen_id   :integer
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#

class User < ApplicationRecord
  belongs_to :last_podcast_seen, class_name: 'Podcast', optional: true

  has_many :podcasts, dependent: :destroy
  has_many :authentications, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :omniauthable,
         :recoverable,
         :rememberable,
         :confirmable,
         :async

  def self.from_omniauth(auth) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/LineLength
    left_joins(:authentications)
      .where(email: auth.info.email)
      .or(
        left_joins(:authentications)
          .where(authentications: { provider: auth.provider, uid: auth.uid })
      )
      .first_or_create do |user|
        omniauth_user = OmniauthUser.new(auth)
        user.assign_attributes(omniauth_user.attributes)
        user.password = Devise.friendly_token
        user.skip_confirmation! if omniauth_user.confirmed?
      end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session['devise.auth_data']
        omniauth_user = OmniauthUser.new(session['devise.auth_data'])
        user.email ||= omniauth_user.email
        user.assign_attributes(omniauth_user.attributes.except(:email))
      end
    end
  end

  def name
    email.split('@').first
  end
end
