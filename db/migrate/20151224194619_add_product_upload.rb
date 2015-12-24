class AddProductUpload < ActiveRecord::Migration
  def change
    add_column :product_edits, :image_uid, :string
  end
end
