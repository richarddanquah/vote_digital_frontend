class AddAvatarUrlToAward < ActiveRecord::Migration[5.1]
  def change
    add_column :awards, :avatar_url, :string
  end
end
