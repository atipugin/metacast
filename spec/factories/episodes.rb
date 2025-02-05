# == Schema Information
#
# Table name: episodes
#
#  id                 :bigint(8)        not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  podcast_id         :bigint(8)        not null
#  source_url         :string           not null
#  state              :string           not null
#  audio              :string
#  image              :string
#  title              :string
#  description        :text
#  author             :string
#  duration           :integer
#  audio_content_type :string
#  audio_size         :integer
#

FactoryBot.define do
  factory :episode do
    podcast
    source_url { FFaker::Internet.http_url }
  end
end
