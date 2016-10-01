module Concerns
  module Utility
    def current_user
      User.find_by(id: session[:id])
    end
  end
end
