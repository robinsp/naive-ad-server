module BrowserCookieAgent
  BROWSER_ID_COOKIE_NAME = "browser-id"
  
  def self.browser_id(controller)
    if cookie = controller.send("cookies").[](BROWSER_ID_COOKIE_NAME)
      CGI::Cookie.parse(cookie)[:browser_id]
    else
      nil
    end
  end

  def self.set_cookie(controller, browser)
    controller.send("cookies").[]=(BROWSER_ID_COOKIE_NAME, {:value => browser.id, :expires => 10.years.from_now})
  end
end