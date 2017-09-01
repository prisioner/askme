class AddIpToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :ip, :string
  end
end
