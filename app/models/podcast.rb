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

class Podcast < ApplicationRecord
  belongs_to :user

  has_many :episodes, dependent: :destroy

  validates :title, presence: true

  has_secure_token

  normalize :title

  mount_uploader :image, ImageUploader
end
