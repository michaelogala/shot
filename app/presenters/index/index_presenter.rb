module Index
  class IndexPresenter
    def recent_links
      Link.newest_first
    end

    def popular_links
      Link.popular
    end

    def influential_users
      User.top_users
    end
  end
end