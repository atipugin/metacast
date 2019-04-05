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
  devise :database_authenticatable, :registerable, :validatable
end
