invoices# RalesEngine

RalesEngine is an API developed by [Daniel Frampton](https://github.com/DanielEFrampton) for the Back-End Engineering program at [Turing School of Software & Design](https://turing.io).

For educational purposes, the development of this app was documented [here](https://gist.github.com/DanielEFrampton/cf5be7daa000a36f52c3fa0e1f434e2c).

[RalesEngine is deployed on Heroku](https://rales-engine-df.herokuapp.com/), and you can also deploy it locally.

## Local Deployment

RalesEngine uses Ruby 2.5.3 and Rails 6.0.2.1. See the included Gemfile for other gem and library dependencies.

Follow these steps in your -nix command line terminal (e.g., the Terminal app in Mac OSX) to set up RalesEngine on your computer:

 - Clone this repo:
```
  git clone git@github.com:DanielEFrampton/rales_engine.git
```
 - Change your working directory to the project's root directory:
```
  cd rales_engine
```
 - Install required gems:
```
  bundle
```
 - Create the database:
```
  rails db:setup
```
 - Start the database:
```
  rails db:{create,migrate,seed}
```
 - Import data from included CSV files (may take several minutes):
 ```
  rake import
```
 - To run test suite:
```
  bundle exec rspec
```
 - To view test coverage:
```
  open coverage/index.html
```
 - Start the Rails server:
```
  rails s
```

## Accessing the API

Using your browser or the [free Postman app](https://www.getpostman.com/), append the following paths to `localhost:3000` if running the server locally or to `https://rales-engine-df.herokuapp.com` if using the Heroku deployment; and also append `/api/v1` before each endpoint. E.g.,
```
localhost:3000/api/v1/merchants/1/
```

If using Postman or another app that allows you to designate the HTTP verb/method, use `GET` for all endpoints.
```
GET localhost:3000/api/v1/merchants/1/
```

If using Chrome, consider using the [JSON Formatter Chrome plug-in](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa) to improve how the JSON data is displayed in your browser.

All resources are RESTful in their organization, and JSON data follows {JSON:API} conventions. Here is an example of the JSON output for a single Item resource:

```json
{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "id": 1,
      "name": "Item Qui Esse",
      "description": "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      "merchant_id": 1,
      "unit_price": "751.07"
    }
  }
}
```

Wherever a word is prefixed by a colon in an API endpoint path, it is a placeholder for the ID of a resource belonging the preceding collection. E.g., in `merchant/:merchant_id`, `:merchant_id` would be replaced by an integer which is the ID attribute of a particular `merchant`.

## API Endpoints

### Record Endpoints

#### Items

- Single Item Record
```
/items/:item_id
```
- All Item Records
```
/items/
```
- Random Item Record
```
/items/random
```
- Find Single Item By Query Parameter
```
/items/find?parameter=value
```
- Find Multiple Items by Query Parameter
```
/items/find_all?parameter=value
```
    Supported Parameters:
    parameter | description | value type/format
    -- | -- | --
    id | search based on the primary key | integer
    name | search based on the name attribute | string (case-insensitive)
    description | search based on the description attribute | string (case-insensitive)
    merchant_id | search based on the merchant_id foreign key | integer
    unit_price | search based on the unit_price attribute | float with 2 decimal places
    created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
    updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

#### Merchants

- Single Merchant Record
```
/merchants/:merchant_id
```
- All Merchant Records
```
/merchants/
```
- Random Merchant Record
```
/merchants/random
```
- Find Single Merchant By Query Parameter
```
/merchants/find?parameter=value
```
- Find Multiple Merchants by Query Parameter
```
/merchants/find_all?parameter=value
```
    Supported Parameters:
    parameter | description | value type/format
    -- | -- | --
    id | search based on the primary key | integer
    name | search based on the name attribute | string (case-insensitive)
    created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
    updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

#### Customers

- Single Customers Record
```
/customers/:customer_id
```
- All Customers Records
```
/customers/
```
- Random Customers Record
```
/customers/random
```
- Find Single Customers By Query Parameter
```
/customers/find?parameter=value
```
- Find Multiple Customers by Query Parameter
```
/customers/find_all?parameter=value
```
    Supported Parameters:
    parameter | description | value type/format
    -- | -- | --
    id | search based on the primary key | integer
    first_name | search based on the first_name attribute | string (case-insensitive)
    last_name | search based on the last_name attribute | string (case-insensitive)
    created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
    updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

#### Invoices

- Single Invoice Record
```
/invoices/:customer_id
```
- All Invoice Records
```
/invoices/
```
- Random Invoice Record
```
/invoices/random
```
- Find Single Invoices By Query Parameter
```
/invoices/find?parameter=value
```
- Find Multiple Invoices by Query Parameter
```
/invoices/find_all?parameter=value
```

Supported Parameters:

parameter | description | value type/format
-- | -- | --
id | search based on the primary key | integer
status | search based on the status attribute | string (case-insensitive)
customer_id | search based on the customer_id foreign key | integer
merchant_id | search based on the merchant_id foreign key | integer
created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

#### InvoiceItems

- Single InvoiceItem Record
```
/invoice_items/:customer_id
```
- All InvoiceItem Records
```
/invoice_items/
```
- Random InvoiceItem Record
```
/invoice_items/random
```
- Find Single InvoiceItem Record By Query Parameter
```
/invoice_items/find?parameter=value
```
- Find Multiple InvoiceItem Records by Query Parameter
```
/invoice_items/find_all?parameter=value
```

Supported Parameters:

parameter | description | value type/format
-- | -- | --
id | search based on the primary key | integer
quantity | search based on the quantity attribute | integer
unit_price | search based on the unit_price attribute | float with 2 decimal places
invoice_id | search based on the invoice_id foreign key | integer
item_id | search based on the item_id foreign key | integer
created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

#### Transactions

- Single Transaction Record
```
/transactions/:customer_id
```
- All Transaction Records
```
/transactions/
```
- Random Transaction Record
```
/transactions/random
```
- Find Single Transaction Record By Query Parameter
```
/transactions/find?parameter=value
```
- Find Multiple Transaction Records by Query Parameter
```
/transactions/find_all?parameter=value
```

Supported Parameters:

parameter | description | value type/format
-- | -- | --
id | search based on the primary key | integer
result | search based on the result attribute | string (case-insensitive)
credit_card_number | based on the credit_card_number attribute | varchar(16)
invoice_id | search based on the invoice_id foreign key | integer
created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

### Relationship Endpoints

#### Merchants

- Merchant-Items (collection of all items associated with given merchant)
```
/merchants/:merchant_id/items
```
- Merchant-Invoices (collection of all invoices associated with given merchant)
```
/merchants/:merchant_id/invoices
```

#### Invoices

- Invoice-Transactions (collection of all transactions associated with given invoice)
```
/invoices/:invoice_id/transactions
```

- Invoice-InvoiceItems (collection of all InvoiceItem records associated with given invoice)
```
/invoices/:invoice_id/invoice_items
```
- Invoice-Items (collection of all items associated with given invoice)
```
/invoices/:invoice_id/items
```
- Invoice-Customer (single customer associated with given invoice)
```
/invoices/:invoice_id/customer
```
- Invoice-Merchant (single merchant associated with given invoice)
```
/invoices/:invoice_id/merchant
```

#### Items

- Item-InvoiceItems (collection of all InvoiceItem records associated with given item)
```
/items/:item_id/invoice_items
```

- Item-Merchant (single merchant associated with given item)
```
/items/:item_id/merchant
```


#### Customers

- Customer-Invoices (collection of all invoices associated with given customer)
```
/customer/:customer_id/invoices
```
- Customer-Transactions (collection of all transactions associated with given customer)
```
/customer/:customer_id/transactions
```

#### Transactions

- Transaction-Invoice (single invoice associated with given transaction)
```
/transactions/:transaction_id/invoice
```

### Business Intelligence Endpoints

- Top `x` Merchants Ranked by Total Revenue
```
/merchants/most_revenue?quantity=x
```
- Total Revenue Generated on Date `x` Across All Merchants
```
/merchants/revenue?date=x
```
- Favorite Customer: Customer who conducted most successful transactions with given merchant
```
/merchants/:merchant_id/favorite_customer
```
- Favorite Merchant: Merchant with whom customer conducted most successful transactions
```
/customers/:customer_id/favorite_merchant
```
- Top `x` Items Ranked by Most Revenue Generated
```
/items/most_revenue?quantity=x
```
- Date with Most Sales for Given Item
```
items/:item_id/best_day
```
