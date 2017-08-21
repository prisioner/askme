class AddUserColorsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_bg_color, :string
    add_column :users, :avatar_border_color, :string
    add_column :users, :profile_text_color, :string
  end
end
