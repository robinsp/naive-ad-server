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
      get 'create', :banner_ad_id => 1
      response.should be_success
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
      Impression.expects(:create).with(:banner_ad => @mock_banner_ad, :browser => @mock_browser)
      get 'create', :banner_ad_id => 1
    end
  end
end