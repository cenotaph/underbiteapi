# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

end
