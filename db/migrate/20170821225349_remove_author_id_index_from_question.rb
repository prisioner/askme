class RemoveAuthorIdIndexFromQuestion < ActiveRecord::Migration[5.1]
  def change
    remove_index :questions, :author_id
  end
end
