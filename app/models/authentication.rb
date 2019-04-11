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

class Authentication < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: %i[user_id provider] }
end
