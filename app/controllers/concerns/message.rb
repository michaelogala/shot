module Concerns
  module Message
    def new_user
      'You successfully signed up'
    end

    def unknown_user
      'You are ont registered. You need to sign up'
    end

    def require_login
      'You need to log in first'
    end

    def log_in_error
      'Invalid username/password combination'
    end

    def new_link_success
      'Link was successfully created'
    end

    def new_link_error
      'Something went wrong. The link couldn\'t be created'
    end

    def display_link(link)
      "#{link.display_slug}"
    end

    def link_deleted
      'Link has been deleted'
    end

    def unknown_link
      'This link doesn\'t exist'
    end

    def link_activated
      'Link has been reactivated'
    end

    def link_deactivated
      'Link has been deactivated'
    end

    def link_updated
      'Link has been updated'
    end

    def logged_in
      'Login Successful'
    end

    def logged_out
      'You have logged out'
    end
  end
end
