class Message

  def self.new_user
    'You successfully signed up'
  end

  def self.unknown_user
    'You are ont registered. You need to sign up'
  end

  def self.sign_up_error
    'All fields are required'
  end

  def self.require_login
    'You need to log in first'
  end

  def self.log_in_error
    'Invalid username/password combination'
  end

  def self.new_link_success
    'Link was successfully created'
  end

  def self.new_link_error
    'Something went wrong. The link couldn\'t be created'
  end

  def self.display_link(link)
    link.display_slug.to_s
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

  def self.logged_in
    'Login Successful'
  end

  def self.logged_out
    'You have logged out'
  end
end
