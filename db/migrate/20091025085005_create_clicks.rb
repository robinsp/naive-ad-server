class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.integer :banner_ad_id, :null => false
      t.integer :browser_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :clicks
  end
end
