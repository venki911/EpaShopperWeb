class StartTime < ActiveRecord::Migration
  def change
    add_column :shop_collections, :start_time, :string
    remove_column :shopper_reports, :test_amount
  end
end
