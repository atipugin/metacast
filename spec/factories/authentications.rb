# == Schema Information
#
# Table name: authentications
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#  provider   :string           not null
#  uid        :string           not null
#  auth_data  :jsonb            not null
#

FactoryBot.define do
  factory :authentication do
    user
    provider { Devise.omniauth_providers.sample }
    uid { FFaker::Random.seed }
  end
end
