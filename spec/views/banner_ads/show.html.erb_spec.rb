require 'spec_helper'

describe "/banner_ads/show" do
  before(:each) do
    
    assigns[:banner_ad] = 
      stub_everything :id => (@banner_id = 1234), 
                      :filename => (@banner_filename = "a-file.ext") 
                      
    render 'banner_ads/show'
  end
  
  it "should have heading with banner id" do 
    response.should have_tag('h1', "Banner Ad #{@banner_id}")
  end
  
  it "should display the banner ad image" do 
    response.should have_tag("img[src=?]", '/images/' + @banner_filename)
  end
end
