class UniqueIndeces < ActiveRecord::Migration[5.0]
  def change
    remove_index :subs, :title
    add_index :subs, :title, unique: true
    add_index :posts, :title, unique: true
  end
end
