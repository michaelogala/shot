class Message
  def self.new_link_success
    'Link was successfully created'
  end

  def self.new_link_error
    'Something went wrong. The link couldn\'t be created'
  end

  def self.link_deleted
    'Link has been deleted'
  end

  def self.unknown_link
    'This link doesn\'t exist'
  end

  def self.link_activated
    'Link has been reactivated'
  end

  def self.link_deactivated
    'Link has been deactivated'
  end

  def self.link_updated
    'Link has been updated'
  end
end