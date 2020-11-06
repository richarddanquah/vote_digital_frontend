class AddCardMonthToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :card_month, :integer
  end
end
