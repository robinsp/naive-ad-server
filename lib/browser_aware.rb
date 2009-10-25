module BrowserAware
  protected
  
  def find_or_create_browser
    if browser_id = BrowserCookieAgent.browser_id(self)
      @browser_instance = Browser.find(browser_id)
    else 
      @browser_instance = Browser.create
      BrowserCookieAgent.set_cookie(self, @browser_instance)
    end
  end
  
  attr_accessor :browser_instance
end