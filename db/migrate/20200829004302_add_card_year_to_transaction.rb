class AddCardYearToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :card_year, :integer
  end
end
