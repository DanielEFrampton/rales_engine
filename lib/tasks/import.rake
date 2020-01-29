# frozen_string_literal: true

desc 'Clear records and import CSV fixture data.'
task import: :environment do
  require 'csv'
  models = [Transaction, InvoiceItem, Item, Invoice, Merchant, Customer]
  models.each(&:destroy_all)
  models.reverse.each do |model|
    CSV.foreach("./data/#{model.to_s.underscore + 's'}.csv",
                headers: true,
                header_converters: :symbol,
                converters: :all) do |row|
      model.create!(row.to_h)
    end
  end
end
