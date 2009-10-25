require 'spec_helper'

describe Browser do
  before(:each) do
    @valid_attributes = {}
  end

  it "should create a new instance given valid attributes" do
    Browser.create!(@valid_attributes)
  end
end
