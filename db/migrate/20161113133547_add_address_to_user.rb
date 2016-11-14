class AddAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address1, :text
    add_column :users, :address2, :text
    add_column :users, :cardtype, :string
    add_column :users, :security, :integer
  end
end
