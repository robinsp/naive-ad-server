require 'factory_girl'

Factory.define(:banner_ad) do |ad|
  ad.filename { "filename.ext" }
end

Factory.define(:browser) do |browser|
end

Factory.define(:impression) do |imp|
  imp.browser  Factory(:browser)
  imp.banner_ad  Factory(:banner_ad)
end
