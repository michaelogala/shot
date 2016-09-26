class Scrape
  include Sidekiq::Worker
  require 'mechanize'

  def perform(link_id)
    link = Link.find(link_id)
    agent = Mechanize.new
    page = agent.get(link.given_url)
    link.title = page.title
    link.save
  end

end