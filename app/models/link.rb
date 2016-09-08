class Link < ActiveRecord::Base
  scope :newest_first, lambda { order("links.created_at DESC") }
  scope :popular, lambda { order("links.clicks DESC").limit(10) }
  after_create :generate_slug

  def generate_slug
    self.slug = (self.id + 31236).to_s(36)
    self.save
  end

  def display_slug
    "http://localhost:3001/" + self.slug
  end
end
