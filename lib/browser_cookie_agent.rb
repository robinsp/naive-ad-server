module BrowserCookieAgent
  BROWSER_ID_COOKIE_NAME = "browser-id"
  
  def self.browser_id(controller)
    controller.send("cookies").[](BROWSER_ID_COOKIE_NAME) || nil
  end

  def self.set_cookie(controller, browser)
    controller.send("cookies").[]=(BROWSER_ID_COOKIE_NAME, {:value => browser.id, :expires => 10.years.from_now})
  end
end