class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits

  scope :newest_first, lambda { order("links.created_at DESC") }
  scope :popular, lambda { order("links.clicks DESC").limit(10) }
  scope :find_url, lambda { select('given_url').where(slug: :slug) }
  after_create :generate_slug

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(4)
    self.save
  end

  def display_slug
    "http://localhost:3001/" + self.slug
  end
end
