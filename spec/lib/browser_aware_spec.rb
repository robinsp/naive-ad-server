require 'spec_helper'

describe "BrowserAware" do 
  before do 
    @controller = Object.new
    @controller.class_eval do 
      include BrowserAware
    end
    
    @browser_stub = stub("Browser", :id => 1234)
    BrowserCookieAgent.stubs(:set_cookie)
  end

  describe "find_or_create_browser()" do
    it "should lookup browser when cookie is set" do 
      browser_id = 1234
      BrowserCookieAgent.expects(:browser_id).with(@controller).returns(browser_id)
      Browser.expects(:find).with(browser_id).returns(@browser_stub)

      @controller.send("find_or_create_browser")
      
      @controller.send("browser_instance").should == @browser_stub
    end
    
    it "should create browser when cookie is not set" do 
      BrowserCookieAgent.expects(:browser_id).with(@controller).returns(nil)
      Browser.expects(:create).returns(@browser_stub)
      
      @controller.send("find_or_create_browser")
      
      @controller.send("browser_instance").should == @browser_stub
    end
    
    it "should set cookie when new browser is created" do 
      Browser.expects(:create).returns(@browser_stub)
      BrowserCookieAgent.stubs(:browser_id).with(@controller).returns(nil)
      BrowserCookieAgent.expects(:set_cookie).with(@controller, @browser_stub)
      @controller.send("find_or_create_browser")
    end
  end
end