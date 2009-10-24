class CreateBannerAds < ActiveRecord::Migration
  def self.up
    create_table :banner_ads do |t|
      t.string :filename
      t.timestamps
    end
  end

  def self.down
    drop_table :banner_ads
  end
end
