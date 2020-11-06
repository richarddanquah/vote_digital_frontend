class CreateAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :awards do |t|
      t.string :name
      t.integer :merchant_id
      t.text :description
      t.integer :user_id
      t.boolean :status
      t.string :avatar

      t.timestamps
    end
  end
end
