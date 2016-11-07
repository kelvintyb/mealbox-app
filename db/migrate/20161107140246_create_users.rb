class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.text :email
      t.integer :contactno
      t.integer :creditcard
      t.date :birthdate

      t.timestamps
    end
  end
end
