class CreateShopperAssignments < ActiveRecord::Migration
  def change

    create_table :assignment_collections do |t|
      t.datetime :delivery_date
      t.timestamps
    end
    create_table :shopper_assignments do |t|
      t.integer :shopper_id
      t.integer :assignment_collection_id
      t.timestamps
    end
    create_table :store_assignments do |t|
      t.string :name
      t.integer :shopper_assignment_id
    end
    create_table :order_assignments do |t|
      t.string :name
      t.integer :shopper_assignment_id
    end

  end
end
