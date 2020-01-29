desc "Clear records and import CSV fixture data."
task import: :environment do
  Transaction.destroy_all
  InvoiceItem.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  Merchant.destroy_all
  Customer.destroy_all

  require 'csv'

  CSV.foreach('./data/customers.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Customer.create!(row.to_h)
  end

  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Merchant.create!(row.to_h)
  end

  CSV.foreach('./data/invoices.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Invoice.create!(row.to_h)
  end

  CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Item.create!(row.to_h)
  end

  CSV.foreach('./data/invoice_items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    InvoiceItem.create!(row.to_h)
  end

  CSV.foreach('./data/transactions.csv', headers: true, header_converters: :symbol, converters: :date_time) do |row|
    Transaction.create!(row.to_h)
  end
end
