require 'mechanize'
class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits

  scope :newest_first, -> { order("links.created_at DESC").limit(5) }
  scope :popular, -> { order("links.clicks DESC").limit(5) }
  scope :find_url, -> { select('given_url').where(slug: :slug) }

  validates :given_url, presence: true
  validates :slug,      uniqueness: true
  before_save :generate_slug, :sanitize_slug

  def self.find_links_for_user(user)
    Link.where(user_id: user.id)
  end

  def self.find_by_id(id)
    Link.find_by(id: id)
  end

  def scrape_title
    self.title = Mechanize.new.get(given_url).title
    save
  end

  def generate_slug
    self.slug ||= SecureRandom.urlsafe_base64(4)
  end

  def sanitize_slug
    self.slug.tr!(' ', '-')
  end

  def display_slug
    ENV['BASE_URL'] + slug
  end

  def add_visit_info(visit)
    visits << visit
    update_attributes(clicks: clicks + 1)
  end
end
