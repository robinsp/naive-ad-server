class Impression < ActiveRecord::Base
  belongs_to :banner_ad
  belongs_to :browser
  
  validates_presence_of :banner_ad, :browser
end
