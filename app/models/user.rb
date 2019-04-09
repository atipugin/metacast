# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string           not null
#  encrypted_password :string           not null
#

class User < ApplicationRecord
  has_many :podcasts, dependent: :destroy

  devise :database_authenticatable, :registerable, :validatable

  def name
    email.split('@').first
  end
end
