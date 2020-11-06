class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :address
      t.string :contact_number
      t.string :contact_email
      t.boolean :status

      t.timestamps
    end
  end
end
