# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  podcast_id :bigint(8)        not null
#  source_url :string           not null
#

class Episode < ApplicationRecord
  belongs_to :podcast

  validates :source_url, presence: true

  normalize :source_url
end
