class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :user
      t.string :given_url, null: false
      t.string :slug
      t.integer :clicks, default: 0
      t.string :title
      t.string :snapshot
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
