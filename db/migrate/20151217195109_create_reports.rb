class CreateReports < ActiveRecord::Migration

    def change
      create_table :shopper_reports do |t|
        t.string :shopper_name
        t.integer :orders_count
        t.integer :items_count
        t.integer :test_amount
        t.integer :total_time
        t.timestamps
      end

      create_table :shop_collections do |t|
        t.string :name
        t.integer :orders_count
        t.integer :items_count
        t.integer :time_taken

        t.timestamps
        t.integer :shopper_report_id
      end

      create_table :line_items do |t|
        t.integer :variant_id, :limit => 8
        t.integer :product_id, :limit => 8
        t.string :title
        t.string :description
        t.string :image_source
        t.float :price
        t.integer :quantity_missing
        t.integer :quantity_substituted
        t.integer :quantity_requested
        t.string :aisle

        t.timestamps
        t.integer :shop_collection_id
      end
    end

end
