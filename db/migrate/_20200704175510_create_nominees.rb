class CreateNominees < ActiveRecord::Migration[5.1]
  def change
    create_table :nominees do |t|
      t.string :name
      t.integer :category_id
      t.text :description
      t.boolean :status
      t.string :avatar2
      t.integer :user_id
      t.string :avatar2_url
      t.string :image3

      t.timestamps
    end
  end
end
