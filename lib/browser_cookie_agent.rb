module BrowserCookieAgent
  BROWSER_ID_COOKIE_NAME = "browser-id"
  
  def self.browser_id(controller)
    protected_cookies_in(controller)[BROWSER_ID_COOKIE_NAME] || nil
  end

  def self.set_cookie(controller, browser)
    protected_cookies_in(controller)[BROWSER_ID_COOKIE_NAME] = {:value => browser.id, :expires => 10.years.from_now}
  end
  
  private 

  def self.protected_cookies_in(controller) 
    controller.send("cookies")
  end
end