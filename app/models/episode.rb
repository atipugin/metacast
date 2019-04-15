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

class Episode < ApplicationRecord
  include AASM

  belongs_to :podcast

  validates :source_url, presence: true

  before_save :set_audio_content_type_and_size

  scope :default_order, -> { order(created_at: :desc) }

  normalize :source_url, :title, :description, :author

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

  private

  def set_audio_content_type_and_size
    return unless audio.present? && audio_changed?

    self[:audio_content_type] = audio.file.content_type
    self[:audio_size] = audio.file.size
  end
end
