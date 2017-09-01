class AddAuthorIpToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :author_ip, :string
  end
end
