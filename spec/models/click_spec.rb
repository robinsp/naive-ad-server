require 'spec_helper'

describe Click do
  before(:each) do
    @valid_attributes = {
      :banner_ad => Factory.create(:banner_ad), 
      :browser => Factory.create(:browser)
    }
  end
  
  it "should create a new instance given valid attributes" do
    Click.create!(@valid_attributes)
  end
  
  [:banner_ad, :browser].each do |attrib|
    it "should require #{attrib.to_s}" do 
      Click.new(@valid_attributes.merge(attrib => nil)).valid?.should be_false
    end
  end
end
