class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :fullname
      t.string :email
      t.string :subject
      t.string :message
      t.boolean :status

      t.timestamps
    end
  end
end
