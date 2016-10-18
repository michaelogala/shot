require 'browser'
class BrowserService
  def initialize(request)
    @request = request
  end

  def browser_params
    browser = Browser.new(@request.user_agent, accept_language: "en-us")
    {
      ip_address:        @request.remote_ip,
      referer:           @request.referer,
      browser_name:      browser.name,
      browser_version:   browser.full_version,
      device:            browser.device.name,
      os:                browser.platform
    }
  end
end
