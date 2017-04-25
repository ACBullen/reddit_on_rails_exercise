class CreateSubs < ActiveRecord::Migration[5.0]
  def change
    create_table :subs do |t|
      t.string :title, presence: true
      t.text :description, presence: true
      t.integer :mod_id, presence: true

      t.timestamps
    end
    add_index :subs, :mod_id
    add_index :subs, :title
  end
end
