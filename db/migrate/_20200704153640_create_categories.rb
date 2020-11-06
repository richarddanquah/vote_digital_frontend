class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :award_id
      t.text :description
      t.boolean :status
      t.integer :user_id
      t.string :avatar1_url
      t.string :image1

      t.timestamps
    end
  end
end
