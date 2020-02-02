# frozen_string_literal: true

desc 'Clear records and import CSV fixture data.'
task import: :environment do
  require 'csv'
  models = [Transaction, InvoiceItem, Item, Invoice, Merchant, Customer]
  puts "Deleting existing data..."
  models.each(&:destroy_all)
  puts "Finished deleting existing data."
  puts "Importing data from CSV files..."
  models.reverse.each do |model|
    puts "Importing #{model} data..."
    CSV.foreach("./data/#{model.to_s.underscore + 's'}.csv",
                headers: true,
                header_converters: :symbol) do |row|
      model.create!(row.to_h)
    end
    puts "Finished importing #{model} data."
  end
  puts "Finished import task. Have a nice day!"
end
