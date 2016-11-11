class DeliveryDateandTime < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :devlierydate, :date
    add_column :transactions, :devlierytime, :time
  end
end
