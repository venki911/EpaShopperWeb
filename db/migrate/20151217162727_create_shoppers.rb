class CreateShoppers < ActiveRecord::Migration
  def change
    create_table :shoppers do |t|
      t.string :username
      t.string :password_digest
      t.timestamps
    end
  end
end
