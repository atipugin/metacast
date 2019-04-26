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
#

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'password' }
  end
end
