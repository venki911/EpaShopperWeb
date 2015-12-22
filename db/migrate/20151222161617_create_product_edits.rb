class CreateProductEdits < ActiveRecord::Migration
  def change
    create_table :product_edits do |t|

      t.integer :variant_id, :limit => 8
      t.integer :product_id, :limit => 8
      t.string :image_source
      t.string :title
      t.string :title_new
      t.string :description
      t.string :description_new
      t.string :aisle
      t.string :aisle_new
      t.float :price
      t.float :price_new

      t.string :shopper_name
      t.boolean :updated, :default => false
      t.timestamps
    end
  end
end
