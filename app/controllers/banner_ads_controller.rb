class BannerAdsController < ApplicationController
  def index
    @banner_ads = BannerAd.all
  end

  def new
  end

  def show
    @banner_ad = BannerAd.find(params[:id])
  end
  
  def create 
    uploaded_file = params[:image_file]
    ad = BannerAd.create_from_upload(uploaded_file.original_filename, uploaded_file.read)
    redirect_to banner_ad_url(ad)
  end

end
