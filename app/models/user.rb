class User < ActiveRecord::Base
  has_many :links
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :top_users, lambda { order('users.link_count DESC').limit(10) }
end
