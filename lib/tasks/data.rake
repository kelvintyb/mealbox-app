require 'csv'

namespace :import_ingredients do
    desc 'Import CSV Data'
    task import: :environment do
        csv_file_path = 'db/data.csv'

        CSV.foreach(csv_file_path) do |row|
            Ingredient.create(name: row[0],
                              category: row[1],
                              cost: row[2],
                              qtyunit: row[3])
            puts 'Row added!'
        end
    end
end

namespace :import_recipies do
    desc 'Import CSV Data'
    task import: :environment do
        csv_file_path = 'db/data2.csv'

        CSV.foreach(csv_file_path) do |row|
            Recipe.create(name: row[0],
                          cuisine: row[1],
                          user_id: row[2],
                          costperserving: row[3])
            puts 'Row added!'
        end
    end
end

namespace :import_recipieIngredients do
    desc 'Import CSV Data'
    task import: :environment do
        csv_file_path = 'db/data3.csv'

        CSV.foreach(csv_file_path) do |row|
             RecipeIngredient.create(ingredient_id: row[0],
                                      recipe_id: row[1],
                                      quantity: row[2]
                                      )
            puts "row added"
        end
    end
end
