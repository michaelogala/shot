class Link < ActiveRecord::Base
  require 'mechanize'
  belongs_to :user
  has_many :visits

  scope :newest_first, lambda { order("links.created_at DESC").limit(5) }
  scope :popular, lambda { order("links.clicks DESC").limit(5) }
  scope :find_url, lambda { select('given_url').where(slug: :slug) }
  after_create :generate_slug_and_scrape

  def generate_slug_and_scrape
    self.slug ||= SecureRandom.urlsafe_base64(4)
    self.title = Mechanize.new
                          .get(self.given_url)
                          .title
    self.save
  end

  def display_slug
    "http://localhost:3001/" + self.slug
  end
end
