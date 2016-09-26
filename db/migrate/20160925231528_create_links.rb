class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :given_url, null: false
      t.string :slug
      t.integer :clicks, default: 0
      t.string :title
      t.string :snapshot
      t.boolean :active, default: true
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :links, :given_url
    add_index :links, :slug
  end
end
