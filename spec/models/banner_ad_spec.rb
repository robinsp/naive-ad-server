require 'spec_helper'

describe BannerAd do
  before(:each) do
    @valid_attributes = { :filename => "filename.ext"}
  end

  it "should not allow the normal save operations" do
    [:create, :create!].each do |op|
      lambda { BannerAd.send(op, @valid_attributes) }.should raise_error(UnsupportedOperationError)
    end
    
    new_ad = BannerAd.new( @valid_attributes )
    [:save, :save!].each do |op|
      lambda { new_ad.send(op) }.should raise_error
    end
  end
  
  it "should require filename" do 
    BannerAd.new(:filename => nil).valid?.should be_false
    BannerAd.new(:filename => "").valid?.should be_false
  end
  
  describe "source_for_image_tag()" do 
    it "should provide file name for image_tag use" do 
      @file_stub = stub_everything
      File.stubs(:new).returns(@file_stub)
      ad = BannerAd.create_from_upload(@filename = "myfile.ext", "file contents")
      ad.source_for_image_tag.should == "/images/#{ad.id}_#{@filename}"
    end
  end
  
  describe "self.create_from_upload" do
    before do 
      @filename = "filename.ext"
      @content = "some content"
      @file_stub = stub_everything
      File.stubs(:new).returns(@file_stub)
    end
    
    it "should require file content" do 
      lambda { BannerAd.create_from_upload(@filename, nil)}.should raise_error(IllegalArgumentError)
    end
    
    it "should return the created instance" do 
      BannerAd.create_from_upload(@filename, @content).should_not be_nil
    end
    
    it "should write file content to file system" do 
      @file_stub.expects(:write).with(@content)
      BannerAd.create_from_upload(@filename, @content)
    end
    
    it "should set file name to id and filename concatenation" do 
      BannerAd.any_instance.stubs(:id).returns(canned_id = 1234)
      File.expects(:new).with(BannerAd::FILE_STORAGE_DIR + "/#{canned_id}_#{@filename}", 'w').returns( @file_stub )
      BannerAd.create_from_upload(@filename, @content)
    end
    
    it "should destroy active record object and re-raise error when IO fails" do 
      @file_stub.expects(:write).raises(StandardError)
      BannerAd.any_instance.expects(:destroy)
      lambda { BannerAd.create_from_upload(@filename, @content) }.should raise_error
    end
  end
end
