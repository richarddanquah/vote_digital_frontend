class AddVoucherToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :voucher, :integer
  end
end
