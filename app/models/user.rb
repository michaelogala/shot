class User < ActiveRecord::Base

  has_many :links
  has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  validates :first_name,  presence: true,
                          length: { maximum: 25 }
  validates :last_name,   presence: true,
                          length: { maximum: 50 }
  validates :email,       presence: true,
                          length: { maximum: 100 },
                          format: EMAIL_REGEX,
                          confirmation: true,
                          uniqueness: true
  scope :top_users, -> { order('users.link_count DESC').limit(5) }
end
