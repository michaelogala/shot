class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :link
      t.string :ip_address
      t.string :browser_name
      t.string :browser_version
      t.string :os
      t.string :referer

      t.timestamps null: false
    end
  end
end
