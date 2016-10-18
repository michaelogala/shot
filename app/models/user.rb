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
                          uniqueness: true
  validates :password,    length: { minimum: 6 },
                          confirmation: true
  validates :password_confirmation, length: { minimum: 6 },
                                    presence: true
  scope :top_users, -> { order('users.link_count DESC').limit(5) }

  def add_new_link(link)
    links << link
    self.link_count += 1
    save
  end
end
