class CreateJoinTableTagLinkedTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tags, :linked_tags do |t|
      t.index [:tag_id, :linked_tag_id]
      t.index [:linked_tag_id, :tag_id]
    end
  end
end
