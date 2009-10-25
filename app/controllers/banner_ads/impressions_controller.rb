class BannerAds::ImpressionsController < ApplicationController
  include BrowserAware
  
  before_filter :find_banner_ad, :find_or_create_browser
  
  def create
    Impression.create(:banner_ad =>  @banner_ad, :browser => self.browser_instance)
  end

  private 
  def find_banner_ad
    @banner_ad = BannerAd.find(params[:banner_ad_id])
  end
end
