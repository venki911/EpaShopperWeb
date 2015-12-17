class ShoppersAdmin < ActiveRecord::Migration
  def change
    add_column :shoppers, :admin, :boolean, default: false
  end
end
