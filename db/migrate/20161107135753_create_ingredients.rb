class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.text :category
      t.float :cost
      t.string :qtyunit
      t.integer :weightgram
      t.float :calories
      t.float :fat
      t.float :cholesterol
      t.float :carbohydrate
      t.float :protein

      t.timestamps
    end
  end
end
