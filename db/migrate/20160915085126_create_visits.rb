class CreateVisits < ActiveRecord::Migration
  def up
    create_table :visits do |t|
      t.references :link
      t.string :ip_address
      t.string :browser_name
      t.string :browser_version
      t.string :device
      t.string :os
      t.string :referer

      t.timestamps null: false
    end
  end

  def down
    drop_table :visits
  end
end
