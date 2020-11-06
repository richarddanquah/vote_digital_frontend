class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :merchant_id
      t.string :trans_id
      t.string :customer_number
      t.string :customer_netowrk
      t.string :trans_type
      t.string :amount
      t.string :reference
      t.boolean :pay_status
      t.integer :award_id
      t.integer :category_id
      t.integer :nominee_id
      t.string :techo_msg
      t.string :payment_types
      t.string :card_name
      t.string :card_email

      t.timestamps
    end
  end
end
