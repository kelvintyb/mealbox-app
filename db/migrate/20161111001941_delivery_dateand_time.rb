class DeliveryDateandTime < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :deliverydate, :date
    add_column :transactions, :deliverytime, :time
  end
end
