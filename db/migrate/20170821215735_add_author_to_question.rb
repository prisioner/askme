class AddAuthorToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_reference :questions, :author, foreign_key: true
  end
end
