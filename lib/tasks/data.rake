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
