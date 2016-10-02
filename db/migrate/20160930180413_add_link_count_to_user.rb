class AddLinkCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :link_count, :integer, default: 0
  end
end
