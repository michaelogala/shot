class RequestDetails

  def self.user_agent_params(request)
    {
      ip:       request.remote_ip,
      referer:  request.referer
    }
  end

  private
    def user_agent
      UserAgent.parse(@request.user_agent)
    end
end
