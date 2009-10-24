require 'spec_helper'

describe BannerAdsController do
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should find all BannerAds" do
      BannerAd.expects(:all).returns(canned_response = "an array")
      get 'index'
      assigns[:banner_ads].should == canned_response
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before do
      @canned_id = 1234.to_s
      BannerAd.stubs(:find).with(@canned_id)
    end

    it "should be successful" do
      get 'show', :id => @canned_id
      response.should be_success
    end
    
    it "should assign the requested ad" do
      BannerAd.expects(:find).with(@canned_id).returns(canned_banner_ad = "an ad")
      get 'show', :id => @canned_id 
      assigns[:banner_ad] = canned_banner_ad
    end
  end
  
  describe "POST 'create'" do 
    before do 
      @uploaded_file = fixture_file_upload("res/avatar.jpeg")
      @mock_banner_ad = stub("BannerAd", :id => 1234)
      BannerAd.stubs(:create_from_upload).returns(@mock_banner_ad)
    end
    
    it "should create BannerAd from the uploaded file" do
      @uploaded_file.stubs(:read).returns(file_content = "some content")
      BannerAd.expects(:create_from_upload).with(@uploaded_file.original_filename, file_content).returns(@mock_banner_ad)
      post :create, :image_file => @uploaded_file
    end
    
    it "should redirect on success" do 
      post :create, :image_file => @uploaded_file
      response.should redirect_to(banner_ad_url(@mock_banner_ad))
    end
  end
end
