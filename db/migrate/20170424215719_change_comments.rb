class ChangeComments < ActiveRecord::Migration[5.0]
  def change
    change_column :comments, :parent_comment_id, :integer, null: true
  end
end
