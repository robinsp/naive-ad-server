require 'spec_helper'

describe BannerAds::ClicksController do
  describe "GET 'create'" do
    before do 
      @mock_banner_ad = mock("BannerAd")
      @mock_browser = mock("Browser")
      
      @controller.stubs(:browser_instance).returns(@mock_browser)
      BannerAd.stubs(:find).returns(@mock_banner_ad)
      Click.stubs(:create).returns(true)
    end
    
    it "should redirect" do 
      get 'create', :banner_ad_id => 1
      response.should redirect_to(BannerAds::ClicksController::DEFAULT_REDIRECT_URL)
    end
    
    it "should lookup BannerAd" do
      BannerAd.expects(:find).with(expected_banner_ad_id = '1234').returns(@mock_banner_ad)
      get 'create', :banner_ad_id => expected_banner_ad_id
    end
    
    it "should ask for Browser" do 
      @controller.expects(:browser_instance).returns(@mock_browser)
      get 'create', :banner_ad_id => 1
    end
    
    it "should create Impression" do 
      Click.expects(:create).with(:banner_ad => @mock_banner_ad, :browser => @mock_browser)
      get 'create', :banner_ad_id => 1
    end
  end
  
  describe "custom_urls" do
    it "should have a custom url for client use" do 
      assert_routing "/a/20899.click", 
        {:method => :get, :controller => 'banner_ads/clicks', :action => 'create', :banner_ad_id => '20899'}
    end
  end
  
end
