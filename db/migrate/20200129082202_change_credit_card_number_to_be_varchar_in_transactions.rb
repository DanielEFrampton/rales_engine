class ChangeCreditCardNumberToBeVarcharInTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :credit_card_number, :string, limit: 16
  end
end
