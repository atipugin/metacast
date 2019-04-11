# == Schema Information
#
# Table name: podcasts
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#  title      :string           not null
#  token      :string           not null
#  image      :string
#

FactoryBot.define do
  factory :podcast do
    user
    title { FFaker::Lorem.word }
  end
end
