# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  podcast_id :bigint(8)        not null
#  source_url :string           not null
#  state      :string           not null
#  audio      :string
#  image      :string
#

class Episode < ApplicationRecord
  include AASM

  belongs_to :podcast

  validates :source_url, presence: true

  normalize :source_url

  aasm column: 'state' do
    state :pending
    state :processed
    state :failed

    event :process do
      transitions from: :pending, to: :processed
    end

    event :fail do
      transitions from: :pending, to: :failed
    end
  end

  mount_uploader :audio, AudioUploader
  mount_uploader :image, ImageUploader
end
