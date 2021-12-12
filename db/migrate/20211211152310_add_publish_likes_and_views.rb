class AddPublishLikesAndViews < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :likes, :integer, default: 0
    add_column :videos, :views, :integer, default: 0
    # add_index :users, :name, unique: true
  end
end
