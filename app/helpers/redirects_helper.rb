module RedirectsHelper
  require 'browser'
  def visit_params(request)
    puts "In visit params method"
    browser = Browser.new(request.user_agent, accept_language: "en-us")
    {
      ip_address:        request.remote_ip,
      referer:           request.referer,
      browser_name:      browser.name,
      browser_version:   browser.full_version,
      device:            browser.device.name,
      os:                browser.platform
    }
  end
end
