class BannerAds::ClicksController < ApplicationController
  include BrowserAware

  DEFAULT_REDIRECT_URL = "http://adserver.se"
  
  before_filter :find_banner_ad, :find_or_create_browser
  
  def create
    Click.create(:banner_ad => @banner_ad, :browser => self.browser_instance)
    redirect_to DEFAULT_REDIRECT_URL
  end
  
  
  private 
  def find_banner_ad
    @banner_ad = BannerAd.find(params[:banner_ad_id])
  end
end
