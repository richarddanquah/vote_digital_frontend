class AddCvvCodeToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :cvv_code, :integer
  end
end
