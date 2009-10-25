require 'factory_girl'

Factory.define(:banner_ad) do |ad|
  ad.filename { "filename.ext" }
end

Factory.define(:browser) do |browser|
end
