class Message
  def self.new_link_success
    "Link successfully created"
  end

  def self.new_link_error
    "Something went wrong. The link couldn't be created"
  end

  def self.link_deleted
    "Link has been deleted"
  end

  def self.unknown_link
    "This link doesn't exist"
  end
end