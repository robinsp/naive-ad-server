require 'spec_helper'

describe BannerAds::ImpressionsController do

  describe "GET 'create'" do
    before do 
      @mock_banner_ad = mock("BannerAd")
      @mock_browser = mock("Browser")
      
      @controller.stubs(:browser_instance).returns(@mock_browser)
      BannerAd.stubs(:find).returns(@mock_banner_ad)
      Impression.stubs(:create).returns(true)
    end
    
    it "should be successful" do
      run_create_action
      response.should be_success
    end
    
    it "should lookup BannerAd" do
      BannerAd.expects(:find).with(expected_banner_ad_id = '1234').returns(@mock_banner_ad)
      get :create, :banner_ad_id => expected_banner_ad_id
    end
    
    it "should ask for Browser" do 
      @controller.expects(:browser_instance).returns(@mock_browser)
      run_create_action
    end
    
    it "should create Impression" do 
      Impression.expects(:create).with(:banner_ad => @mock_banner_ad, :browser => @mock_browser)
      run_create_action
    end
    
    it "should not use layout" do 
      run_create_action
      response.layout.should be_nil
    end
    
    def run_create_action
      get :create, :banner_ad_id => 1
    end
  end
  
  describe "custom_urls" do
    it "should have a custom url for client use" do 
      assert_routing "/a/20899.iframe", 
        {:method => :get, :controller => 'banner_ads/impressions', :action => 'create', :banner_ad_id => '20899'}
    end
  end
end
