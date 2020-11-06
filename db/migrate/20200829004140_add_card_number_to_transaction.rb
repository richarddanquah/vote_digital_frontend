class AddCardNumberToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :card_number, :integer
  end
end
