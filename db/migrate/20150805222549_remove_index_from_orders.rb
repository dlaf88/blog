class RemoveIndexFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :index, :string
    remove_column :orders, :show, :string
    remove_column :orders, :new, :string
  end
end
