require 'spec_helper'

describe "/banner_ads/impressions/create" do
  before(:each) do
    @banner_ad = Factory(:banner_ad)
    assigns[:banner_ad] = @banner_ad
    render 'banner_ads/impressions/create'
  end

  it "should have an image with a click link" do
    response.should have_tag("a[href=?][target='_blank']", click_ad_url(@banner_ad) ) do 
      with_tag "img[src=?]", @banner_ad.source_for_image_tag
    end
  end
  
end
