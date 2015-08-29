class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :shipping_name
      t.string :billing_name
      t.string :index
      t.string :show
      t.string :new

      t.timestamps null: false
    end
  end
end
