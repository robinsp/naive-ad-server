UnsupportedOperationError = Class.new(StandardError)
IllegalArgumentError = Class.new(StandardError)

class BannerAd < ActiveRecord::Base
  FILE_STORAGE_DIR = "#{RAILS_ROOT}/public"
  validates_presence_of :filename
  
  def before_save
    unless @created_with_class_method
      raise UnsupportedOperationError.new("Use BannerAd.create_from_upload(uploaded_file) to create")
    end
  end
  
  def self.create_from_upload(filename, file_content)
    raise IllegalArgumentError.new("An UploadedFile is required") if file_content.nil?
    
    new_ad = self.new(:filename => filename)
    new_ad.instance_eval { @created_with_class_method = true }
    
    if new_ad.save
      begin
        File.new(FILE_STORAGE_DIR + "/#{new_ad.id}_#{new_ad.filename}", "w").write(file_content)
      rescue StandardError => e
        new_ad.destroy
        raise e
      end
    end
    
    return new_ad
  end
  
  private 
  
  attr_accessor :created_with_class_method
end
