class CrossPosting < ActiveRecord::Migration[5.0]
  def change
    create_table :postings do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
    add_index :postings, :post_id
    add_index :postings, :sub_id

    remove_column :posts, :sub_id
  end
end
