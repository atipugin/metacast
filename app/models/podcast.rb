# == Schema Information
#
# Table name: podcasts
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#  title      :string           not null
#

class Podcast < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  normalize :title
end
