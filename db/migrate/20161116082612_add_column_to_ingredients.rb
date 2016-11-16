class AddColumnToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :weightgram, :integer
    add_column :ingredients, :calories, :float
    add_column :ingredients, :fat, :float
    add_column :ingredients, :cholesterol, :float
    add_column :ingredients, :carbohydrate, :float
    add_column :ingredients, :protein, :float
  end
end
