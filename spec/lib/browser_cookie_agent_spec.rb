require 'spec_helper'

describe BrowserCookieAgent do
  before do 
    @cookies_stub = stub_everything
    @response_stub = stub_everything
    
    @controller = ActionController::Base.new
    @controller.stubs(:cookies).returns(@cookies_stub)
  end
  
  describe "self.browser_id()" do
    it "should return nil when cookie isn't set" do 
      @cookies_stub.expects(:[]).with(BrowserCookieAgent::BROWSER_ID_COOKIE_NAME).returns(nil)
      BrowserCookieAgent.browser_id(@controller).should be_nil
    end
    
    it "should return the browser id set in cookie" do
      expected_browser_id = 1234
      @cookies_stub.expects(:[]).with(BrowserCookieAgent::BROWSER_ID_COOKIE_NAME).returns(cookie_string = "fake")
      
      CGI::Cookie.expects(:parse).with(cookie_string).returns( {:browser_id => expected_browser_id} )
      BrowserCookieAgent.browser_id(@controller).should == expected_browser_id
    end
  end
  
  describe "self.set_cookie" do
    before do 
      @browser_stub = stub_everything(:id => (browser_id = 1234) )
    end
    
    it "should create a cookie named '#{BrowserCookieAgent::BROWSER_ID_COOKIE_NAME}'" do 
      @cookies_stub.expects(:[]=).with() do |cookie_name, values| 
        cookie_name.should == BrowserCookieAgent::BROWSER_ID_COOKIE_NAME
      end
      
      BrowserCookieAgent.set_cookie(@controller, @browser_stub)
    end
    
    it "should create a cookie with the Browser.id" do 
      @cookies_stub.expects(:[]=).with() do |cookie_name, values| 
        values[:value].should == @browser_stub.id
      end
                                     
      BrowserCookieAgent.set_cookie(@controller, @browser_stub)
    end
    
    it "should created cookie with expiration date" do 
      @cookies_stub.expects(:[]=).with() do |cookie_name, values|
        values.has_key?(:expires).should be_true
      end
      
      BrowserCookieAgent.set_cookie(@controller, @browser_stub)
    end
    
  end
  
end